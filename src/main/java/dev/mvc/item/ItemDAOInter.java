package dev.mvc.item;

import java.util.ArrayList;

public interface ItemDAOInter {
  
  public int create(ItemVO dogVO);
  
  public ArrayList<ItemVO> list_all();
  
  public ItemVO read(int itemno);
  
  public int update(ItemVO dogVO);
  
  public int delete(int itemno);
  
  public int update_seqno_decrease(int itemno);

  public int update_seqno_increase(int itemno);
  
  public int update_visible_y(int itemno);
  
  public int update_visible_n(int itemno);
  
  public ArrayList<ItemVO> list_all_y();
  
  public int update_cnt_add(int itemno);
  
  public int update_cnt_sub(int itemno);
  
}
