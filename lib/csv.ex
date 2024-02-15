defmodule Csv do
  @spec parse(binary()) :: {:ok, [map()]} | {:error, String.t()}
  def parse(file_name) do
    case file_exist(file_name) do
      {:ok, _} ->
        file_name
        |> File.read()
        |> handle_file_read()
        |> file_empty()
      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec handle_file_read({:error, any()} | {:ok, binary()}) :: {:error, any()} | {:ok, list()}
  def handle_file_read({:ok, result}) do
    result =
      result
      |> String.split("\r\n")
      |> Enum.map(&String.split(&1, ","))
      |> remove_first_row()
      |> Enum.map(&convert_to_map/1)

    {:ok, result}
  end

  def handle_file_read({:error, reason}), do: {:error, reason}

  def remove_first_row([_ | body]) do
    body
  end

  def convert_to_map(row) do
    headers = ["City","Country","Date of Foundation","Population"]

    case length(row) == length(headers) do
      true ->
        Enum.zip(headers,row)
        |> Map.new()
      false ->
        {:error,"Invalid CSV"}
    end
  end

  def file_exist(file) do
    case File.exists?(file) do
      true ->
        {:ok, file}
      false ->
        {:error, "File not found"}
    end
  end

  def file_empty(file) do
    case file != {:ok, []} do
      true ->
        file
      false ->
        {:error, "File is empty"}
    end
  end
end
