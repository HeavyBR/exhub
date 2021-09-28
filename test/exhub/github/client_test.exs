defmodule Exhub.Github.ClientTest do
  use ExUnit.Case, async: true

  alias Exhub.Github.Client

  describe "get_repos/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, returns the repos", %{bypass: bypass} do
      mock = get_mock_res()
      url = endpoint_url(bypass.port)
      username = "capivara"

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, mock)
      end)

      response = Client.get_repos(username, url)

      expected_res =
        {:ok,
         [
           %{
             "html_url" => "https://github.com/danilo-vieira/audio_processing",
             "id" => 247_000_001,
             "name" => "audio_processing",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/be-the-hero_SemanaOmniStack11",
             "id" => 250_401_242,
             "name" => "be-the-hero_SemanaOmniStack11",
             "stargazers_count" => 1
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/bootcamp-gostack-desafios",
             "id" => 288_580_155,
             "name" => "bootcamp-gostack-desafios",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/card-manager",
             "id" => 256_151_208,
             "name" => "card-manager",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/conceitos-nodejs",
             "id" => 253_994_687,
             "name" => "conceitos-nodejs",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/conceitos-react-native",
             "id" => 254_952_852,
             "name" => "conceitos-react-native",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/conceitos-reactjs",
             "id" => 254_571_784,
             "name" => "conceitos-reactjs",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/Curso-em-Video",
             "id" => 226_739_311,
             "name" => "Curso-em-Video",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/danilo-vieira",
             "id" => 278_727_243,
             "name" => "danilo-vieira",
             "stargazers_count" => 3
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/danilo-vieira.github.io",
             "id" => 251_211_733,
             "name" => "danilo-vieira.github.io",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/db_e_upload_files-nodejs",
             "id" => 257_178_828,
             "name" => "db_e_upload_files-nodejs",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/ecoleta-nlw",
             "id" => 268_552_116,
             "name" => "ecoleta-nlw",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/express-typescript-template",
             "id" => 269_272_951,
             "name" => "express-typescript-template",
             "stargazers_count" => 1
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/fundamentos-nodejs",
             "id" => 256_062_426,
             "name" => "fundamentos-nodejs",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/fundamentos-react-native",
             "id" => 260_375_810,
             "name" => "fundamentos-react-native",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/fundamentos-reactjs",
             "id" => 257_773_591,
             "name" => "fundamentos-reactjs",
             "stargazers_count" => 1
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/github-explorer",
             "id" => 257_753_476,
             "name" => "github-explorer",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/gobarber-backend",
             "id" => 263_409_061,
             "name" => "gobarber-backend",
             "stargazers_count" => 4
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/gobarber-web",
             "id" => 287_057_801,
             "name" => "gobarber-web",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/happy-backend-deploy",
             "id" => 304_164_260,
             "name" => "happy-backend-deploy",
             "stargazers_count" => 2
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/happy-web-deploy",
             "id" => 304_422_124,
             "name" => "happy-web-deploy",
             "stargazers_count" => 1
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/ignite-conceitos-do-nodejs",
             "id" => 346_227_754,
             "name" => "ignite-conceitos-do-nodejs",
             "stargazers_count" => 3
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/ignite-reactjs-carrinho-de-compras",
             "id" => 392_137_709,
             "name" => "ignite-reactjs-carrinho-de-compras",
             "stargazers_count" => 0
           },
           %{
             "html_url" =>
               "https://github.com/danilo-vieira/ignite-reactjs-componentizando-a-aplicacao",
             "id" => 391_174_553,
             "name" => "ignite-reactjs-componentizando-a-aplicacao",
             "stargazers_count" => 0
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/ignite-reactjs-conceitos-do-react",
             "id" => 391_169_160,
             "name" => "ignite-reactjs-conceitos-do-react",
             "stargazers_count" => 1
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/ignite-reactjs-dtmoney",
             "id" => 397_390_972,
             "name" => "ignite-reactjs-dtmoney",
             "stargazers_count" => 0
           },
           %{
             "html_url" =>
               "https://github.com/danilo-vieira/ignite-reactjs-refact-class-to-function",
             "id" => 400_695_363,
             "name" => "ignite-reactjs-refact-class-to-function",
             "stargazers_count" => 0
           },
           %{
             "html_url" =>
               "https://github.com/danilo-vieira/ignite-template-otimizando-a-aplicacao",
             "id" => 392_402_695,
             "name" => "ignite-template-otimizando-a-aplicacao",
             "stargazers_count" => 1
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/LivrariaSI",
             "id" => 191_988_996,
             "name" => "LivrariaSI",
             "stargazers_count" => 2
           },
           %{
             "html_url" => "https://github.com/danilo-vieira/MQTT-protocol",
             "id" => 207_615_107,
             "name" => "MQTT-protocol",
             "stargazers_count" => 0
           }
         ]}

      assert response == expected_res
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"

  defp get_mock_res() do
    Path.expand("../../support/fixtures/github_repos_mock_res.json", __DIR__)
    |> File.read!()
  end
end
