package dev.mvc.dog;

import java.util.ArrayList;

public interface DogProcInter {

  public int create(DogVO dogVO);
  
  public ArrayList<DogVO> list_all();
  
  public DogVO read(int itemno);
  
  public int update(DogVO dogVO);
  
  public int delete(int itemno);
  
  public int update_seqno_decrease(int itemno);

  public int update_seqno_increase(int itemno);
  
  public int update_visible_y(int itemno);
  
  public int update_visible_n(int itemno);
  
  public ArrayList<DogVO> list_all_y();
  
  public int update_cnt_add(int itemno);
  
  public int update_cnt_sub(int itemno);
  
}
