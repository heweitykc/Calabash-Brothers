package com.game.vipcopy.control
{
    import com.*;
    import com.game.card.message.*;
    import com.game.vipcopy.protocol.*;
    import com.game.vipcopy.view.*;
    import com.game.zones.control.*;

    public class VipCopyControl extends Object
    {
        private var _vipCopyBox:VipCopyBox;
        private var _vipCopySurePanel:VipCopySurePanel;
        private var _protocol:VipCopyProtocol;
        private static var _instance:VipCopyControl;

        public function VipCopyControl()
        {
            this._protocol = new VipCopyProtocol();
            return;
        }// end function

        public function get vipCopyBox() : VipCopyBox
        {
            return this._vipCopyBox;
        }// end function

        public function openVipCopyBox() : void
        {
            if (!this._vipCopyBox)
            {
                this._vipCopyBox = new VipCopyBox();
                Global.popManager.addPop(this._vipCopyBox);
            }
            this._vipCopyBox.openOrClose();
            return;
        }// end function

        public function openVipCopyBossBox() : void
        {
            if (this._vipCopyBox)
            {
                this._vipCopyBox.choose(1);
            }
            return;
        }// end function

        public function openVipCopyEnterBox() : void
        {
            if (this._vipCopyBox)
            {
                this._vipCopyBox.choose(2);
            }
            return;
        }// end function

        public function openVipCopySurePanel() : void
        {
            if (!this._vipCopySurePanel)
            {
                this._vipCopySurePanel = new VipCopySurePanel();
                Global.popManager.addPop(this._vipCopySurePanel, false, false, true, true, false, true);
            }
            this._vipCopySurePanel.openOrClose();
            return;
        }// end function

        public function reqEnterVipCopy(param1:int, param2:int) : void
        {
            ZonesControl.getInstance().reqZoneTeamEnterToGame(param1, param2);
            return;
        }// end function

        public function resCardPhoneHandler(param1:ResCardPhoneToClientMessage) : void
        {
            return;
        }// end function

        public static function getInstance() : VipCopyControl
        {
            if (_instance == null)
            {
                _instance = new VipCopyControl;
            }
            return _instance;
        }// end function

    }
}
