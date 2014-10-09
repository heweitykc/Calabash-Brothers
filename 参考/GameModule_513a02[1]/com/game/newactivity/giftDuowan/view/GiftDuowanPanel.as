package com.game.newactivity.giftDuowan.view
{
    import com.cfg.obj.*;
    import com.game.newactivity.gift.view.*;
    import com.staticdata.*;

    public class GiftDuowanPanel extends GiftPanel
    {

        public function GiftDuowanPanel()
        {
            activityId = NewActivityConfig.ACTID_GIFT_DUOWAN;
            activityGroupId = NewActivityConfig.GROUP_GIFT_DUOWAN;
            panelResourceUrl = "res/giftDuowanPanel.swf";
            panelResourceClassName = "giftDuowanPanel";
            rowResourceClassName = "giftDuowanRowView";
            ruleWebsite = GlobalCfgObj.getInstance().getGiftDuowanRuleWebsite();
            init();
            return;
        }// end function

    }
}
