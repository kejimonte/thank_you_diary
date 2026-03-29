// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const init = () => {
  const btn = document.getElementById("ai-btn");
  if (!btn) return;

  btn.addEventListener("click", async () => {
    const content = document.getElementById("content_field").value;

    if (!content) {
      alert("内容を入力してください");
      return;
    }

    btn.disabled = true;
    btn.innerText = "生成中...";

    try {
      const res = await fetch("/thanks/ai_generate", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({ content: content })
      });

      const data = await res.json();
      document.getElementById("content_field").value = data.text;

    } catch (e) {
      alert("AI生成に失敗しました");
    }

    btn.disabled = false;
    btn.innerText = "AIで整える";
  });
};

document.addEventListener("turbo:load", init);
document.addEventListener("DOMContentLoaded", init);