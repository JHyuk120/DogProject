package dev.mvc.item;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.item.ItemProc")
public class ItemProc implements ItemProcInter {
  @Autowired
  private ItemDAOInter itemDAO;
  
  @Override
  public int create(ItemVO itemVO) {
    int cnt = this.itemDAO.create(itemVO);
    
    return cnt;
  }
  
  @Override
  public ArrayList<ItemVO> list_all() {
    
    ArrayList<ItemVO> list = this.itemDAO.list_all();
    
    return list;
  }

  @Override
  public ItemVO read(int itemno) {
    ItemVO itemVO = this.itemDAO.read(itemno);
    
    return itemVO;
  }

  @Override
  public int update(ItemVO itemVO) {
    int cnt =this.itemDAO.update(itemVO);
    
    return cnt;
  }

  @Override
  public int delete(int itemno) {
    int cnt = this.itemDAO.delete(itemno);
    
    return cnt;
  }

  @Override
  public int update_seqno_decrease(int itemno) {
    int cnt = this.itemDAO.update_seqno_decrease(itemno);
    return cnt;
  }
  
  @Override
  public int update_seqno_increase(int itemno) {
    int cnt = this.itemDAO.update_seqno_increase(itemno);
    return cnt;
  }

  @Override
  public int update_visible_y(int itemno) {
    int cnt = this.itemDAO.update_visible_y(itemno);
    return cnt;
  }

  @Override
  public int update_visible_n(int itemno) {
    int cnt = this.itemDAO.update_visible_n(itemno);
    return cnt;
  }

  @Override
  public ArrayList<ItemVO> list_all_y() {
    ArrayList<ItemVO> list_y = this.itemDAO.list_all_y();
    
    return list_y;
  }

  @Override
  public int update_cnt_add(int itemno) {
    int cnt = this.itemDAO.update_cnt_add(itemno);
    return cnt;
  }

  @Override
  public int update_cnt_sub(int itemno) {
    int cnt = this.itemDAO.update_cnt_sub(itemno);
    return cnt;
  }

}
