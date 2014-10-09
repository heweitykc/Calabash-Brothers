package com.game.primaryrole.control
{
    import com.*;
    import com.game.player.message.*;
    import com.game.primaryrole.model.*;
    import com.game.primaryrole.protocol.*;
    import com.game.primaryrole.view.*;
    import com.model.vo.*;
    import flash.display.*;

    public class OtherRoleControl extends Object
    {
        private var _playerInfo:PlayerInfo;
        private var otherRoleProtocol:OtherRoleProtocol;
        private var _otherRoleMainPanel:OtherRoleMainPanel;
        private var _otherArtifactView:OtherArtifactView;
        private var _otherMagicBookView:OtherMagicBookView;
        private static var _instance:OtherRoleControl;

        public function OtherRoleControl()
        {
            this.otherRoleProtocol = new OtherRoleProtocol();
            return;
        }// end function

        public function get playerInfo() : PlayerInfo
        {
            return this._playerInfo;
        }// end function

        public function set playerInfo(param1:PlayerInfo) : void
        {
            this._playerInfo = param1;
            return;
        }// end function

        public function get otherArtifactView() : OtherArtifactView
        {
            if (!this._otherArtifactView)
            {
                this._otherArtifactView = new OtherArtifactView();
            }
            return this._otherArtifactView;
        }// end function

        public function getOtherMagicBookView() : OtherMagicBookView
        {
            if (!this._otherMagicBookView)
            {
                this._otherMagicBookView = new OtherMagicBookView();
            }
            return this._otherMagicBookView;
        }// end function

        public function openOtherRoleMainPanel(param1:PlayerInfo, param2:String = "role") : void
        {
            if (!this._otherRoleMainPanel)
            {
                this._otherRoleMainPanel = new OtherRoleMainPanel();
                Global.popManager.addPop(this._otherRoleMainPanel);
            }
            this._otherRoleMainPanel.type = param2;
            this._otherRoleMainPanel.playInfo = param1;
            this.playerInfo = param1;
            this._otherRoleMainPanel.reqData(param1.personId);
            return;
        }// end function

        public function removeHorse() : void
        {
            if (OtherHorseControl.getInstance().otherHorseView.parent)
            {
                OtherHorseControl.getInstance().otherHorseView.parent.removeChild(OtherHorseControl.getInstance().otherHorseView);
            }
            return;
        }// end function

        public function addHorse() : void
        {
            if (this._otherRoleMainPanel.isOpen)
            {
                OtherHorseControl.getInstance().otherHorseView.move(81, 3);
                DisplayObjectContainer(this._otherRoleMainPanel.getDisplay()).addChildAt(OtherHorseControl.getInstance().otherHorseView, (this._otherRoleMainPanel.index - 1));
            }
            return;
        }// end function

        public function removeArtifact() : void
        {
            if (this.otherArtifactView.parent)
            {
                this.otherArtifactView.parent.removeChild(this.otherArtifactView);
            }
            return;
        }// end function

        public function addArtifact() : void
        {
            if (this._otherRoleMainPanel.isOpen)
            {
                this.otherArtifactView.move(81, 3);
                DisplayObjectContainer(this._otherRoleMainPanel.getDisplay()).addChildAt(this.otherArtifactView, (this._otherRoleMainPanel.index - 1));
            }
            return;
        }// end function

        public function removeMagicBook() : void
        {
            if (this._otherMagicBookView && this._otherMagicBookView.parent)
            {
                this._otherMagicBookView.parent.removeChild(this._otherMagicBookView);
            }
            return;
        }// end function

        public function addMagicBook() : void
        {
            if (this._otherRoleMainPanel.isOpen)
            {
                this.getOtherMagicBookView().move(81, 3);
                DisplayObjectContainer(this._otherRoleMainPanel.getDisplay()).addChildAt(this.getOtherMagicBookView(), (this._otherRoleMainPanel.index - 1));
            }
            return;
        }// end function

        public function reqOtherPlayerInfo() : void
        {
            this.otherRoleProtocol.reqOtherPlayerInfo(this.playerInfo.personId, 0);
            this.otherRoleProtocol.reqOtherPlayerInfo(this.playerInfo.personId, 1);
            return;
        }// end function

        public function reqOtherPlayerHorse() : void
        {
            this.otherRoleProtocol.reqOtherPlayerInfo(this.playerInfo.personId, 0);
            this.otherRoleProtocol.reqOtherPlayerInfo(this.playerInfo.personId, 1);
            return;
        }// end function

        public function otherPlayerInfoHandler(param1:ResOtherPlayerInfoMessage) : void
        {
            this.playerInfo.otherPlayerInfoMessage = param1;
            OtherEquipsData.getInstance().data = param1.equips;
            if (this._otherRoleMainPanel)
            {
                if (this._otherRoleMainPanel.parent)
                {
                    this._otherRoleMainPanel.parent.setChildIndex(this._otherRoleMainPanel, (this._otherRoleMainPanel.parent.numChildren - 1));
                }
                this._otherRoleMainPanel.open();
                this._otherRoleMainPanel.updateUI();
            }
            return;
        }// end function

        public function updateOtherMagicBook() : void
        {
            this._otherMagicBookView.updateUI();
            return;
        }// end function

        public static function getInstance() : OtherRoleControl
        {
            if (_instance == null)
            {
                _instance = new OtherRoleControl;
            }
            return _instance;
        }// end function

    }
}
