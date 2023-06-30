package dev.mvc.recommend;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.recipe.RecipeDAOInter;

@Component("dev.mvc.recommend.RecommendProc")
public class RecommendProc implements RecommendProcInter {
    @Autowired
    private RecommendDAOInter recommendDAO;

    @Override
    public ArrayList<RecommendVO> recommend(int itemno) {
        ArrayList<RecommendVO> list = this.recommendDAO.recommend(itemno);
        return list;
    }

    @Override
    public int recommend_read(int memberno) {
        int recommendVO = this.recommendDAO.recommend_read(memberno);
        return recommendVO;
    }

    @Override
    public int recommend_cnt(int memberno) {
        int cnt = this.recommendDAO.recommend_cnt(memberno);
        return cnt;
    }



}
