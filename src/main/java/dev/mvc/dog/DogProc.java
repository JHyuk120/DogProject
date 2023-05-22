package dev.mvc.dog;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.dog.DogProc")
public class DogProc implements DogProcInter {
  @Autowired
  private DogDAOInter dogDAO;
  
  @Override
  public int create(DogVO dogVO) {
    int cnt = this.dogDAO.create(dogVO);
    
    return cnt;
  }
  
  @Override
  public ArrayList<DogVO> list_all() {
    
    ArrayList<DogVO> list = this.dogDAO.list_all();
    
    return list;
  }

  @Override
  public DogVO read(int itemno) {
    DogVO dogVO = this.dogDAO.read(itemno);
    
    return dogVO;
  }

  @Override
  public int update(DogVO dogVO) {
    int cnt =this.dogDAO.update(dogVO);
    
    return cnt;
  }

  @Override
  public int delete(int itemno) {
    int cnt = this.dogDAO.delete(itemno);
    
    return cnt;
  }

  @Override
  public int update_seqno_decrease(int itemno) {
    int cnt = this.dogDAO.update_seqno_decrease(itemno);
    return cnt;
  }
  
  @Override
  public int update_seqno_increase(int itemno) {
    int cnt = this.dogDAO.update_seqno_increase(itemno);
    return cnt;
  }

  @Override
  public int update_visible_y(int itemno) {
    int cnt = this.dogDAO.update_visible_y(itemno);
    return cnt;
  }

  @Override
  public int update_visible_n(int itemno) {
    int cnt = this.dogDAO.update_visible_n(itemno);
    return cnt;
  }

  @Override
  public ArrayList<DogVO> list_all_y() {
    ArrayList<DogVO> list_y = this.dogDAO.list_all_y();
    
    return list_y;
  }

  @Override
  public int update_cnt_add(int itemno) {
    int cnt = this.dogDAO.update_cnt_add(itemno);
    return cnt;
  }

  @Override
  public int update_cnt_sub(int itemno) {
    int cnt = this.dogDAO.update_cnt_sub(itemno);
    return cnt;
  }

}
