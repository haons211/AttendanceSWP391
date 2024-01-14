document.getElementById("attendance").addEventListener("click", function(){
    showContent("attendance"); 
});

document.getElementById("profile").addEventListener("click", function(){
    showContent("profile");
}); 
document.getElementById("application").addEventListener("click", function(){
    showContent("application");
}); 
document.getElementById("showapplication").addEventListener("click", function(){
    showContent("showapplication");
}); 
function showContent(id) {

    // Ẩn hết các nội dung đi 
    document.getElementById("attendance-content").style.display = "none";
    document.getElementById("profile-content").style.display = "none";
    document.getElementById("application-content").style.display = "none";
    document.getElementById("showapplication-content").style.display = "none";
    // Hiển thị nội dung được click
    document.getElementById(id + "-content").style.display = "block";
}
