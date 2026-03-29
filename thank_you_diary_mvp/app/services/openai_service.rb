class OpenaiService
  def self.generate(text)
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "あなたは人の感謝を美しく整えるプロです。" },
          { role: "user", content: "次の文章を感謝が伝わるように整えてください: #{text}" }
        ]
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
