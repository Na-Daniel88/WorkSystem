package kr.co.work.vo;

import java.util.List;

public class PagingVO<T> {
	// 실제 데이터가 저장될 리스트
	private List<T> list;
	
	// 4개의 변수는 넘겨받는다
	private int totalCount;		// 전체 글 수
	private int currentPage;	// 현재 페이지
	private int pageSize;		// 페이지당 글 수
	private int blockSize;		// 하단의 페이지 표시수
	
	//나머지는 계산해서 넣는다
	private int totalPage;		// 전체 페이지 수
	private int startNo;		// 시작 글번호
	private int endNo;			// 끝 글번호 : 오라클에서만 사용
	private int startPage;		// 시작 페이지 번호
	private int endPage;		// 끝 페이지 번호
	
	// 4개를 넘겨받는 생성자 만들기
	public PagingVO(int totalCount, int currentPage, int pageSize, int blockSize) {
		super();
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.blockSize = blockSize;
		calc();		// 계산해주는 메서드 호출
	}
	// 나머지 변수들을 계산해서 넣어주는 메서드
	private void calc()
	{
		if(totalCount<0)
		{
			totalCount = 0;
		}
		if(currentPage<=0)
		{
			currentPage = 1;
		}
		if(pageSize<=0)
		{
			pageSize = 10;
		}
		if(blockSize<=0)
		{
			blockSize = 10;
		}
		if(totalCount>0) 
		{
			totalPage = (totalCount-1)/pageSize + 1;
			// 현재 페이지는 전체 페이지보다 클 수 없다
			if(currentPage > totalPage)
			{
				currentPage = 1;
			}
			startNo = (currentPage-1) * pageSize + 1;		// 오라클의 경우 +1
			endNo = startNo + pageSize - 1;
			// 유효성 검사를 한다
			if(endNo>=totalCount)
			{
				endNo = totalCount;		// 오라클의 경우는 -1을 하지 않는다.
			}
			startPage = (currentPage-1) / blockSize * blockSize + 1;
			endPage = startPage + blockSize - 1;
			if(endPage > totalPage)
			{
				endPage = totalPage;
			}
		}
	}
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getStartNo() {
		return startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	@Override
	public String toString() {
		return "PagingVO [list=" + list + ", totalCount=" + totalCount + ", currentPage=" + currentPage + ", pageSize="
				+ pageSize + ", blockSize=" + blockSize + ", totalPage=" + totalPage + ", startNo=" + startNo
				+ ", endNo=" + endNo + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
	// 메서드 추가
	public String getPageInfo()
	{
		String info = "전체 : " + totalCount + "개";
		if(totalCount>0)
		{
			info += "(" + currentPage + "/" + totalPage + "Page)";
		}
		return info;
	}
	
	public String getPageList()
	{
		if(totalCount<=0)
		{
			return "";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("<ul class='pagination justify-content-center'>");
		// 이전 : 시작페이지 번호가 1보다 큰경우에만
		if(startPage>1)
		{
			sb.append("<li class='page-item'>");
			sb.append("<a class='page-link' href='javascript:post_to_url(\"?\",{\"p\":" + (startPage-1) + ",\"s\":" + pageSize + ",\"b\":" + blockSize + "})' aria-label='Previous'>");
			sb.append("<span aria-hidden='true'>&laquo;</span>");
			sb.append("</a>");
			sb.append("</li>");
		}
		// 페이지 리스트 : 시작페이지 번호 부터 끝페이지 번호까지 반복
		for(int i=startPage;i<=endPage;i++)
		{
			// 현재 보고 있는 페이지는 링크를 걸지 않느다
			if(currentPage==i)
			{
				sb.append("<li class='page-item active'><a class='page-link' href='#'>" + i + "</a></li>");
			}
			else
			{
				sb.append("<li class='page-item'><a class='page-link' href='javascript:post_to_url(\"?\",{\"p\":" + i + ",\"s\":" + pageSize + ",\"b\":" + blockSize + "})'>" + i + "</a></li>");
			}
			
		}
		// 다음 : 마지막 페이지 번호가 전체 페이지 번호보다 적은 경우에만
		if(endPage<totalPage)
		{
			sb.append("<li class='page-item'>");
			sb.append("<a class='page-link' href='javascript:post_to_url(\"?\",{\"p\":" + (endPage+1) + ",\"s\":" + pageSize + ",\"b\":" + blockSize + "})' aria-label='Next'>");
			sb.append("<span aria-hidden='true'>&raquo;</span>");
			sb.append("</a>");
			sb.append("</li>");
		}
		sb.append("</ul>");
		return sb.toString();
	}
}

























