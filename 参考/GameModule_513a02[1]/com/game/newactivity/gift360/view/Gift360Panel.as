package com.game.newactivity.gift360.view
{
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.game.newactivity.gift.view.*;
    import com.staticdata.*;

    public class Gift360Panel extends GiftPanel
    {

        public function Gift360Panel()
        {
            activityId = NewActivityConfig.ACTID_GIFT_360;
            activityGroupId = NewActivityConfig.GROUP_GIFT_360;
            panelResourceUrl = "res/gift360Panel.swf";
            panelResourceClassName = "gift360Panel";
            rowResourceClassName = "gift360RowView";
            ruleWebsite = GlobalCfgObj.getInstance().getGift360Website();
            init();
            return;
        }// end function

        override public function onLeadingRowClick() : void
        {
            JSTools.openWindow(GlobalCfgObj.getInstance().getGift360LeadingRowActivityWebsite());
            return;
        }// end function

    }
}
