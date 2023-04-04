defmodule Pento.Search do
  defstruct [:sku]
  @types %{sku: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = struct, attrs \\ %{}) do
    {struct, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(Map.keys(@types))
    |> validate_length(:sku, is: 7)
  end
end
