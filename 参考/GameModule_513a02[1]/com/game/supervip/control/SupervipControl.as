package com.game.supervip.control
{
    import com.game.supervip.message.*;
    import com.game.supervip.model.*;
    import com.game.supervip.protocol.*;
    import com.game.supervip.view.*;

    public class SupervipControl extends Object
    {
        private var protocol:SupervipProtocol;
        private var supervipData:SupervipData;
        private var supervipPanel:SupervipPanel;
        private static var instance:SupervipControl;

        public function SupervipControl()
        {
            this.protocol = new SupervipProtocol();
            this.supervipData = SupervipData.getInstance();
            return;
        }// end function

        public function openOrCloseSupervipPanel() : void
        {
            if (this.supervipPanel == null)
            {
                this.supervipPanel = new SupervipPanel();
            }
            this.supervipPanel.openOrClose();
            return;
        }// end function

        public function reqGetSuperVipInfo() : void
        {
            this.protocol.reqGetSuperVipInfo();
            return;
        }// end function

        public function resGetSuperVipInfo(param1:ResGetSuperVipInfoMessage) : void
        {
            this.supervipData.updateData(param1);
            return;
        }// end function

        public static function getInstance() : SupervipControl
        {
            var _loc_1:* = new SupervipControl;
            instance = new SupervipControl;
            return instance || _loc_1;
        }// end function

    }
}
