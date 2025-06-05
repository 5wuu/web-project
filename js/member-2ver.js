// 讀取 localStorage 內的帳號密碼資料
let registeredUsers = JSON.parse(localStorage.getItem("registeredUsers")) || {};

// 🔹 登入與註冊視窗控制
function openLoginWindow() {
  document.getElementById("login-modal").style.display = "block";
}
function closeLoginWindow() {
  document.getElementById("login-modal").style.display = "none";
}
function openRegisterWindow() {
  document.getElementById("register-modal").style.display = "block";
}
function closeRegisterWindow() {
  document.getElementById("register-modal").style.display = "none";
}

// 🔹 註冊功能處理
document.getElementById("register-form").addEventListener("submit", function (e) {
  e.preventDefault();

  const username = document.getElementById("reg-username").value.trim();
  const password = document.getElementById("reg-password").value.trim();
  const name = document.getElementById("reg-name").value.trim();
  const phone = document.getElementById("reg-phone").value.trim();
  const email = document.getElementById("reg-email").value.trim();

  if (!username || !password) {
    alert("請完整填寫帳號與密碼");
    return;
  }

  if (registeredUsers[username]) {
    alert("此帳號已註冊！");
    return;
  }

  // 加入新會員並存入 localStorage
  registeredUsers[username] = { password, name, phone, email };
  localStorage.setItem("registeredUsers", JSON.stringify(registeredUsers));

  alert("註冊成功！歡迎選購！");
  closeRegisterWindow();
  document.getElementById("register-form").reset();
});

// 🔹 登入功能處理
document.getElementById("login-form").addEventListener("submit", function (e) {
  e.preventDefault();

  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value.trim();
  const errorMsg = document.getElementById("error-message");

  if (!registeredUsers[username]) {
    errorMsg.textContent = "尚未註冊！";
    errorMsg.style.display = "block";
  } else if (registeredUsers[username].password !== password) {
    errorMsg.textContent = "帳號或密碼錯誤！";
    errorMsg.style.display = "block";
  } else {
    // ✅ 登入成功時儲存會員姓名
    const user = registeredUsers[username];
    localStorage.setItem("current_user", user.name);

    alert("登入成功，歡迎 " + user.name + "！");
    closeLoginWindow();
    document.getElementById("login-form").reset();
    errorMsg.style.display = "none";

    const memberCenter = document.getElementById("member-center");
    if (memberCenter) {
      memberCenter.innerText = user.name + "，您好｜";
    }
  }
});
