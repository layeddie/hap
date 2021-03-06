defmodule HAP.Characteristics.CurrentHeaterCoolerState do
  @moduledoc """
  Definition of the `public.hap.characteristic.heater-cooler.state.current` characteristic

  Valid values:

  0 Inactive
  1 Idle
  2 Heating
  3 Cooling
  """

  @behaviour HAP.CharacteristicDefinition

  def type, do: "B1"
  def perms, do: ["pr", "ev"]
  def format, do: "uint8"
  def min_value, do: 0
  def max_value, do: 3
  def step_value, do: 1
end
