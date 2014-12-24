defmodule ChiefThundercloud.Api do
  def init(_transport, _req, _opts) do
        {:upgrade, :protocol, :cowboy_rest}
  end

  def allowed_methods(req, state) do
      {[<<"GET">>, <<"PUT">>], req, state}
  end

  def content_types_provided(req, state) do
        {[{{"application", "json", []}, :get_json}], req, state}
  end

  def content_types_accepted(req, state) do
        {[{{"application", "json", :*}, :post_binary}], req, state}
  end

  def get_json(req, state) do
    {info, req} = {[], req}
    {response(info), req, state}
  end

  def post_binary(req, _state) do
    {true, req, nil}
  end

  defp response(info) do
    info |> JSEX.encode!
  end
end

