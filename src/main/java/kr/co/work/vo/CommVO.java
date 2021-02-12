package kr.co.work.vo;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class CommVO {
	private int p;
	private int s;
	private int b;
	private int idx;
	private int currentPage;
	private int pageSize;
	private int blockSize;
	
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
		currentPage = p;
		if(currentPage<=0) {
			currentPage = 1;
			this.p = 1;
		}
	}
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
		pageSize = s;
		if(pageSize<=1) {
			pageSize=10;
			this.s  =10;
		}
	}
	
	public int getB() {
		return b;
	}
	
	public void setB(int b) {
		this.b = b;
		blockSize = b;
		if(blockSize<=1) {
			blockSize=10;
			this.b  =10;
		}
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	@Override
	public String toString() {
		return "CommVO [p=" + p + ", s=" + s + ", b=" + b + ", idx=" + idx + ", currentPage=" + currentPage
				+ ", pageSize=" + pageSize + ", blockSize=" + blockSize + "]";
	}
}
