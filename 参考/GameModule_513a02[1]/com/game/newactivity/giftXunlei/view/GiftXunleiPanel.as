package com.game.newactivity.giftXunlei.view
{
    import com.cfg.obj.*;
    import com.game.newactivity.gift.view.*;
    import com.staticdata.*;

    public class GiftXunleiPanel extends GiftPanel
    {

        public function GiftXunleiPanel()
        {
            activityId = NewActivityConfig.ACTID_GIFT_XUNLEI;
            activityGroupId = NewActivityConfig.GROUP_GIFT_XUNLEI;
            panelResourceUrl = "res/giftXunleiPanel.swf";
            panelResourceClassName = "giftXunleiPanel";
            rowResourceClassName = "giftXunleiRowView";
            ruleWebsite = GlobalCfgObj.getInstance().getGiftXunleiRulesite();
            init();
            return;
        }// end function

    }
}
