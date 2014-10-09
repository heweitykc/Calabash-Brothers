package com.game.newactivity.gift37.view
{
    import com.cfg.obj.*;
    import com.game.newactivity.gift.view.*;
    import com.staticdata.*;

    public class Gift37Panel extends GiftPanel
    {

        public function Gift37Panel()
        {
            activityId = NewActivityConfig.ACTID_GIFT_37;
            activityGroupId = NewActivityConfig.GROUP_GIFT_37;
            panelResourceUrl = "res/gift37Panel.swf";
            panelResourceClassName = "gift37Panel";
            rowResourceClassName = "gift37RowView";
            ruleWebsite = GlobalCfgObj.getInstance().getGift37RuleWebsite();
            init();
            return;
        }// end function

    }
}
