package com.game.supervip.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import com.view.tipcell.*;

    public class SupervipTitleView extends BaseSprite
    {
        private var viewTitle:VMCView;

        public function SupervipTitleView()
        {
            this.viewTitle = new VMCView();
            addChild(this.viewTitle);
            return;
        }// end function

        public function setTitleId(param1:int) : void
        {
            var _loc_2:* = new TitleVO();
            _loc_2.titleid = param1;
            _loc_2.isModel = true;
            var _loc_3:* = TitleCfgObj.getInstance().getTitleById(param1);
            this.viewTitle.auto = true;
            this.viewTitle.loadRes(_loc_3.url, null, true);
            this.viewTitle.updatePose("90", true);
            ItemTips.create(this, _loc_2, TitleTips);
            return;
        }// end function

    }
}
