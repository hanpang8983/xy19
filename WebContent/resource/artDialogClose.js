function toClose(){
    var dialog = top.dialog.get(window);
    dialog.close(); // 关闭（隐藏）对话框
    dialog.remove();                 // 主动销毁对话框
    return false;
}