defmodule HAP.Service do
  @moduledoc """
  Represents a single service, containing a number of characteristics
  """

  defstruct type: nil, characteristics: []

  @typedoc """
  Represents a service of a given type, containing a number of characteristics
  """
  @type t :: %__MODULE__{
          type: type(),
          characteristics: [HAP.Characteristic.t()]
        }

  @typedoc """
  The type of a service as defined in Section 6.6.1 of Apple's [HomeKit Accessory Protocol Specification](https://developer.apple.com/homekit/).
  """
  @type type :: String.t()

  @doc false
  @spec compile(HAP.ServiceSource.t()) :: t()
  def compile(source) do
    service = source |> HAP.ServiceSource.compile()

    characteristics = service.characteristics |> Enum.reject(fn {_characteristic_mod, value} -> is_nil(value) end)

    %{service | characteristics: characteristics}
  end

  @doc false
  def ensure_required!(module, name, nil), do: raise("Value for #{name} required for service definition #{module}")
  def ensure_required!(_module, _name, _characteristic_value), do: :ok

  @doc false
  def get_characteristic(%__MODULE__{characteristics: characteristics}, iid) do
    with {:ok, characteristic_index} <- HAP.IID.characteristic_index(iid),
         characteristic when not is_nil(characteristic) <- Enum.at(characteristics, characteristic_index) do
      {:ok, characteristic}
    else
      _ -> {:error, -70_409}
    end
  end

  # Provide an identity transform for services to allow for direct definition of services within a `HAP.Accessory`
  defimpl HAP.ServiceSource do
    def compile(value), do: value
  end
end
