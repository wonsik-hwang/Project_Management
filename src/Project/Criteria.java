package Project;


public class Criteria {
    
    private int page;
    private int perPageNum;
    
    public int getPageStart() {
        return (this.page-1)*perPageNum;
    }
    
    public Criteria() {
        this.page = 1;
        this.perPageNum = 10;
    }
    
    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    public int getPerPageNum() {
        return perPageNum;
    }
    public void setPerPageNum(int pageCount) {
        int cnt = this.perPageNum;
        if(pageCount != cnt) {
            this.perPageNum = cnt;
        } else {
            this.perPageNum = pageCount;
        }
    }
    
}





//public class Criteria {
//	
//	private int page;
//	private int perPageNum;
//	private int rowStart;
//	private int rowEnd;
//	
//	public Criteria() {
//		this.page = 1;
//		this.perPageNum = 10;
//	}
//
//	public void setPage(int page) {
//		if (page <= 0) {
//			this.page = 1;
//			return;
//		}
//		this.page = page;
//	}
//	
//	public void setPerPageNum(int perPageNum) {
//		if (perPageNum <= 0 || perPageNum > 100) {
//			this.perPageNum = 10;
//			return;
//		}
//		this.perPageNum = perPageNum;
//	}
//	
//	public int getPage() {
//		return page;
//	}
//	
//	public int getPageStart() {
//		return (this.page - 1) * perPageNum;
//	}
//	
//	public int getPerPageNum() {
//		return this.perPageNum;
//	}
//	
//	public int getRowStart() {
//		rowStart = ((page -1) * perPageNum) + 1;
//		return rowStart;
//	}
//	
//	public int getRowEnd() {
//		rowEnd = rowStart + perPageNum - 1;
//		return rowEnd;
//	}
//	
//	@Override
//	public String toString() {
//		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd + "]";
//	}
//	
//	
//}
