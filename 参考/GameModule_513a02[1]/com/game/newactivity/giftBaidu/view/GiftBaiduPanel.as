package com.game.newactivity.giftBaidu.view
{
    import com.cfg.obj.*;
    import com.game.newactivity.gift.view.*;
    import com.staticdata.*;

    public class GiftBaiduPanel extends GiftPanel
    {

        public function GiftBaiduPanel()
        {
            activityId = NewActivityConfig.ACTID_GIFT_BAIDU;
            activityGroupId = NewActivityConfig.GROUP_GIFT_BAIDU;
            panelResourceUrl = "res/giftBaiduPanel.swf";
            panelResourceClassName = "giftBaiduPanel";
            rowResourceClassName = "giftBaiduRowView";
            ruleWebsite = GlobalCfgObj.getInstance().getGiftBaiduRuleWebsite();
            init();
            return;
        }// end function

    }
}
