defmodule HAP.Characteristics.Hue do
  @moduledoc """
  Definition of the `public.hap.characteristic.hue` characteristic
  """

  @behaviour HAP.CharacteristicDefinition

  def type, do: "13"
  def perms, do: ["pr", "pw", "ev"]
  def format, do: "float"
  def min_value, do: 0.0
  def max_value, do: 360.0
  def step_value, do: 1.0
  def unit, do: "arcdegrees"
end
