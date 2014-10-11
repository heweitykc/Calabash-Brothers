package com.game.vip.control
{
    import com.*;
    import com.game.vip.bean.*;
    import com.game.vip.consts.*;
    import com.game.vip.model.*;
    import com.game.vip.protocol.*;
    import com.game.vip.view.*;

    public class VIPControl extends Object
    {
        private var _vipLevel:int;
        private var _vipinfo:VipInfo;
        private var _protocol:VIPProtocol;
        private var _vippanel:VIPPanel;
        private var _infoPanel:VIPInfoPanel;
        private var _viperpanel:VIPerPanel;
        private var _captionPanel:VIPCaptionPanel;
        private static var _inst:VIPControl;

        public function VIPControl()
        {
            this._protocol = new VIPProtocol();
            return;
        }// end function

        public function get vipinfo() : VipInfo
        {
            return VipModel.getInstance().info;
        }// end function

        public function set vipinfo(param1:VipInfo) : void
        {
            VipModel.getInstance().info = param1;
            if (VipModel.getInstance().info.stageLevel > VipConst.EXPERIENCE_LEVEL && VipModel.getInstance().isOpeningVip)
            {
                VipModel.getInstance().isOpeningVip = false;
                this.openOrCloseVip();
            }
            if (this._vippanel && this._vippanel.UILoaded)
            {
                this._vippanel.info = param1;
            }
            if (this._viperpanel && this._viperpanel.UILoaded)
            {
                this._viperpanel.info = param1;
            }
            return;
        }// end function

        public function get vipLevel() : int
        {
            return this._vipLevel;
        }// end function

        public function set vipLevel(param1:int) : void
        {
            this._vipLevel = param1;
            return;
        }// end function

        public function closeRecommand() : void
        {
            if (this._viperpanel)
            {
                this._viperpanel.closeRecommand();
            }
            return;
        }// end function

        public function openOrCloseVip() : void
        {
            var _loc_1:* = VipModel.getInstance().info;
            if (_loc_1.stageLevel > VipConst.EXPERIENCE_LEVEL)
            {
                if (this._viperpanel == null)
                {
                    this._viperpanel = new VIPerPanel();
                    Global.popManager.addPop(this._viperpanel);
                }
                this._viperpanel.openOrClose();
            }
            else
            {
                if (this._vippanel == null)
                {
                    this._vippanel = new VIPPanel();
                    Global.popManager.addPop(this._vippanel);
                }
                this._vippanel.openOrClose();
            }
            return;
        }// end function

        public function openOrCloseInfoPanel(param1:int) : void
        {
            if (this._infoPanel == null)
            {
                this._infoPanel = new VIPInfoPanel();
                Global.popManager.addPop(this._infoPanel);
            }
            this._infoPanel.vip = param1;
            this._infoPanel.openOrClose();
            return;
        }// end function

        public function openOrCloseCaptionPanel() : void
        {
            if (this._captionPanel == null)
            {
                this._captionPanel = new VIPCaptionPanel();
                Global.popManager.addPop(this._captionPanel);
            }
            this._captionPanel.openOrClose();
            return;
        }// end function

        public function openVip(param1:int, param2:int, param3:String = "") : void
        {
            this._protocol.openVip(param1, param2, param3);
            return;
        }// end function

        public static function getInstance() : VIPControl
        {
            var _loc_1:* = new VIPControl;
            _inst = new VIPControl;
            return _inst || _loc_1;
        }// end function

    }
}
