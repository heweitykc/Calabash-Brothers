package com.game.primaryrole.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.events.*;
    import com.game.artifact.control.*;
    import com.game.artifact.model.*;
    import com.game.artifact.view.*;
    import com.game.buff.control.*;
    import com.game.elementHeart.control.*;
    import com.game.elementHeart.model.*;
    import com.game.guide.model.*;
    import com.game.horse.control.*;
    import com.game.horse.view.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.game.primaryrole.protocol.*;
    import com.game.primaryrole.view.*;
    import com.game.remark.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class PrimaryRoleControl extends Object
    {
        private var _primaryRoleMain:PrimaryRoleMainPanel;
        private var _roloInfo:RoleInfoPanel;
        private var _talentPlus:RoleTalentPlusPanel;
        private var _titlePanel:TitleViewPanel;
        private var _protocol:PrimaryRoleProtocol;
        private static var instance:PrimaryRoleControl;

        public function PrimaryRoleControl()
        {
            this._protocol = new PrimaryRoleProtocol();
            return;
        }// end function

        public function openPrimayRoleMain() : void
        {
            if (!this._primaryRoleMain)
            {
                this._primaryRoleMain = new PrimaryRoleMainPanel();
                Global.popManager.addPop(this._primaryRoleMain);
            }
            this._primaryRoleMain.type = PrimaryRoleMainPanel.ROLE;
            if (!this._primaryRoleMain.isOpen && HorseControl.getInstance().horseView && HorseControl.getInstance().horseView.stage)
            {
                HorseControl.getInstance().horseView.close();
            }
            if (!this._talentPlus)
            {
                this._talentPlus = new RoleTalentPlusPanel();
                Global.popManager.addPop(this._talentPlus);
            }
            if (this._roloInfo && this._roloInfo.isOpen)
            {
                this._roloInfo.openOrClose();
            }
            if (this._titlePanel && this._titlePanel.isOpen)
            {
                this._titlePanel.close();
            }
            if (!this._primaryRoleMain.isOpen)
            {
                this._primaryRoleMain.open();
                TweenLite.killDelayedCallsTo(this._talentPlus.open);
                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)) != 0)
                {
                    TweenLite.delayedCall(0.3, this._talentPlus.open);
                }
            }
            else
            {
                this._primaryRoleMain.close();
                TweenLite.killDelayedCallsTo(this._talentPlus.close);
                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)) != 0)
                {
                    TweenLite.delayedCall(0.3, this._talentPlus.close);
                }
            }
            return;
        }// end function

        public function updateMagicAtkLow() : void
        {
            if (this._roloInfo && this._roloInfo.isOpen)
            {
                this._roloInfo.updateMagicAttack();
            }
            if (this._talentPlus && this._talentPlus.isOpen)
            {
                this._talentPlus.updateMagicAttack();
            }
            return;
        }// end function

        public function setWaterLight(param1:uint, param2:Number = 1) : void
        {
            this._primaryRoleMain.setWaterLight(param1, param2);
            return;
        }// end function

        public function changeRemark(param1:String) : void
        {
            RemarkModel.getInstance().self.prase(param1);
            if (this._primaryRoleMain)
            {
                this._primaryRoleMain.createAttributeTips();
            }
            return;
        }// end function

        public function initHorse() : void
        {
            if (this._primaryRoleMain)
            {
                this._primaryRoleMain.dealHorse();
            }
            return;
        }// end function

        public function openInfo() : void
        {
            if (!this._roloInfo)
            {
                this._roloInfo = new RoleInfoPanel();
                Global.popManager.addPop(this._roloInfo);
            }
            this._roloInfo.openOrClose();
            return;
        }// end function

        public function openTalentPlus() : void
        {
            if (!this._talentPlus)
            {
                this._talentPlus = new RoleTalentPlusPanel();
                Global.popManager.addPop(this._talentPlus);
            }
            this._talentPlus.openOrClose();
            return;
        }// end function

        public function openTitlePanel(param1:int = 0) : void
        {
            if (!this._titlePanel)
            {
                this._titlePanel = new TitleViewPanel();
                Global.popManager.addPop(this._titlePanel);
            }
            this._titlePanel.titledId(param1);
            this._titlePanel.open();
            return;
        }// end function

        public function get lowMagicAttack() : int
        {
            var _loc_3:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            var _loc_2:* = _loc_1.magic_attacklower;
            if (_loc_1.jobkind == JobType.MAGICER)
            {
                if (BuffControl.getInstance().hasLowLimitBuff)
                {
                    _loc_3 = BuffCfgObj.getInstance().getBuffInfo(BuffSpecilId.LOW_LIMIT);
                    _loc_2 = _loc_2 + (_loc_1.magic_attackupper - _loc_1.magic_attacklower) * (_loc_3.q_effect_ratio / 10000);
                }
            }
            return _loc_2;
        }// end function

        public function addPointRes(param1:int) : void
        {
            if (this._talentPlus)
            {
                this._talentPlus.addPointRes(param1);
            }
            if (this._primaryRoleMain)
            {
                this._primaryRoleMain.checkEquip();
            }
            return;
        }// end function

        public function closeInfo() : void
        {
            if (this._talentPlus && this._talentPlus.isOpen)
            {
                this._talentPlus.close();
            }
            if (this._roloInfo && this._roloInfo.isOpen)
            {
                this._roloInfo.close();
            }
            return;
        }// end function

        public function openExtraPanel(param1:int) : void
        {
            if (param1 == 1)
            {
                if (this._primaryRoleMain == null || !this._primaryRoleMain.isOpen)
                {
                    this.openPrimayRoleMain();
                    return;
                }
                if (this._talentPlus == null || !this._talentPlus.isOpen)
                {
                    this.openTalentPlus();
                }
            }
            return;
        }// end function

        public function getRoleView() : PrimaryRoleMainPanel
        {
            var _loc_1:* = new PrimaryRoleMainPanel();
            this._primaryRoleMain = new PrimaryRoleMainPanel();
            return this._primaryRoleMain || _loc_1;
        }// end function

        public function addPoint(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._protocol.addPoint(param1, param2, param3, param4);
            return;
        }// end function

        public function removeHorse() : void
        {
            var _loc_1:* = HorseControl.getInstance().horseView;
            if (_loc_1)
            {
                _loc_1.removeFromParent();
            }
            return;
        }// end function

        public function removeArtifact() : void
        {
            var _loc_1:* = ArtifactControl.getInstance().artifactView;
            if (_loc_1 && _loc_1.parent)
            {
                _loc_1.removeFromParent();
            }
            return;
        }// end function

        public function removeMagicBookView() : void
        {
            var _loc_1:* = MagicBookControl.getIntance().magicBookView;
            if (_loc_1 && _loc_1.parent)
            {
                _loc_1.removeFromParent();
            }
            return;
        }// end function

        public function removeElementHeartView() : void
        {
            var _loc_1:* = ElementHeartControl.getInstance().elementHeartView;
            if (_loc_1 && _loc_1.parent)
            {
                _loc_1.removeFromParent();
            }
            return;
        }// end function

        public function openHorse() : void
        {
            if (!UserObj.getInstance().playerInfo.horseInfo)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11029"));
                return;
            }
            this.openRoleMainPanelTab(PrimaryRoleMainPanel.HORSE);
            return;
        }// end function

        public function openArtifactExtract() : void
        {
            if (!ArtifactData.getInstance().isArtifactEnabled())
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11030"));
                return;
            }
            this.openRoleMainPanelTab(PrimaryRoleMainPanel.ARTIFACT_EXTRACT);
            return;
        }// end function

        public function openArtifact() : void
        {
            if (!ArtifactData.getInstance().isArtifactEnabled())
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11030"));
                return;
            }
            this.openRoleMainPanelTab(PrimaryRoleMainPanel.ARTIFACT);
            return;
        }// end function

        public function openMagicBook() : void
        {
            if (MagicBookData.canOpenPanel() && UserObj.getInstance().playerInfo.magicBook)
            {
                this.openRoleMainPanelTab(PrimaryRoleMainPanel.MAGIC_BOOK);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10724"));
            }
            return;
        }// end function

        public function openElementHeart() : void
        {
            if (ElementHeartData.getInstance().enable())
            {
                this.openRoleMainPanelTab(PrimaryRoleMainPanel.ELEMENT_HEART);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10724"));
            }
            return;
        }// end function

        private function openRoleMainPanelTab(param1:String) : void
        {
            if (!this._primaryRoleMain)
            {
                this._primaryRoleMain = new PrimaryRoleMainPanel();
                Global.popManager.addPop(this._primaryRoleMain);
                this._primaryRoleMain.addEventListener(BoxEvent.SHOW_HIDE, this._closeHandler);
            }
            this._primaryRoleMain.type = param1;
            this._primaryRoleMain.openOrClose();
            return;
        }// end function

        public function addHorse() : void
        {
            if (this._primaryRoleMain.isOpen)
            {
                HorseControl.getInstance().initHorseView();
                HorseControl.getInstance().horseView.move(82, 0);
                this._primaryRoleMain.addDisplay(HorseControl.getInstance().horseView);
            }
            return;
        }// end function

        public function addArtifact() : Boolean
        {
            if (this._primaryRoleMain.isOpen)
            {
                ArtifactControl.getInstance().initArtifactView();
                ArtifactControl.getInstance().artifactView.move(82, 0);
                this._primaryRoleMain.addDisplay(ArtifactControl.getInstance().artifactView);
                return true;
            }
            return false;
        }// end function

        public function addMagicBook() : Boolean
        {
            var _loc_1:* = null;
            if (this._primaryRoleMain.isOpen)
            {
                _loc_1 = MagicBookControl.getIntance().initMagicBook();
                _loc_1.move(82, 0);
                this._primaryRoleMain.addDisplay(_loc_1);
                MagicBookControl.getIntance().reqMagicbook();
                return true;
            }
            return false;
        }// end function

        public function addElementHeart() : Boolean
        {
            var _loc_1:* = null;
            if (this._primaryRoleMain.isOpen)
            {
                _loc_1 = ElementHeartControl.getInstance().initElementHeartView();
                _loc_1.move(82, 0);
                this._primaryRoleMain.addDisplay(_loc_1);
                ElementHeartControl.getInstance().openElementHousePanel();
                return true;
            }
            return false;
        }// end function

        public function addArtifactExtract() : void
        {
            if (this.addArtifact())
            {
                ArtifactControl.getInstance().openOrCloseExtractPanel();
            }
            return;
        }// end function

        private function _closeHandler(event:BoxEvent) : void
        {
            if (HorseControl.getInstance().horseView && event.showOrHide == 1)
            {
                HorseControl.getInstance().horseView.close();
            }
            return;
        }// end function

        public function isRoleTalentPlusPanelOpen() : Boolean
        {
            return this._talentPlus && this._talentPlus.isOpen;
        }// end function

        public static function getInstance() : PrimaryRoleControl
        {
            var _loc_1:* = new PrimaryRoleControl;
            instance = new PrimaryRoleControl;
            return instance || _loc_1;
        }// end function

    }
}
