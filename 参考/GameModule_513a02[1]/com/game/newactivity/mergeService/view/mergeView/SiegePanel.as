package com.game.newactivity.mergeService.view.mergeView
{
    import com.f1.ui.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;

    public class SiegePanel extends Component
    {
        private var advert2:MovieClip;
        private var advert4:MovieClip;
        private var warTimePanel:WarTimePanel;

        public function SiegePanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.advert2 = getDisplayChildByName("advert2");
            this.advert4 = getDisplayChildByName("advert4");
            this.warTimePanel = new WarTimePanel(getDisplayChildByName("warTimePanel"));
            return;
        }// end function

        public function setInfo(param1:int, param2:NewActivityInfo) : void
        {
            this.advert2.visible = param1 == NewActivityConfig.ACTID_WAR2_MERGE;
            this.advert4.visible = param1 == NewActivityConfig.ACTID_WAR4_MERGE;
            this.warTimePanel.setInfo(param1, param2);
            return;
        }// end function

        public function clearInfo() : void
        {
            this.warTimePanel.clearInfo();
            return;
        }// end function

    }
}
