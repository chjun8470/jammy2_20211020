function board_manager()
{
	if (!chk_checkbox(boardListForm, 'chks', true))
	{
		alert('게시글을 선택해 주세요');
		return;
	}

	window.open('', "board_manage", 'scrollbars=no,width=700,height=600');
	document.boardListForm.act.value='manage';
	document.boardListForm.target='board_manage';
	document.boardListForm.submit();
}