package com.game.primaryrole.view
{
    import avmplus.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.artifact.cfg.*;
    import com.game.horse.control.*;
    import com.game.magicbook.control.*;
    import com.game.primaryrole.control.*;
    import com.game.role.util.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class OtherRoleMainPanel extends BaseBox
    {
        private var _masterTab:BaseButton;
        private var _horseTab:BaseButton;
        private var _artifactTab:BaseButton;
        private var _magicBookTab:BaseButton;
        private var txt_title:TextField;
        private var closeBtn:BaseButton;
        private var _roleView:OtherRoleMainView;
        private var _playInfo:PlayerInfo;
        private var _index:int = 0;
        private var _tabBtns:Buttons;
        private var _type:String;
        public static const HORSE:String = "horse";
        public static const ROLE:String = "role";
        public static const ARTIFACT:String = "artifact";
        public static const MAGICBOOK:String = "magicbook";

        public function OtherRoleMainPanel()
        {
            _peaceBox = ["*"];
            loadDisplay("res/primaryroleother.swf");
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get playInfo() : PlayerInfo
        {
            return this._playInfo;
        }// end function

        public function set playInfo(param1:PlayerInfo) : void
        {
            this._playInfo = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("primaryrolepanel2");
            this.initUI();
            super.displayReady();
            OtherRoleControl.getInstance().reqOtherPlayerInfo();
            return;
        }// end function

        private function initUI() : void
        {
            this._tabBtns = new Buttons();
            this._masterTab = new BaseButton(getDisplayChildByName("tabMaster"), true);
            this._horseTab = new BaseButton(getDisplayChildByName("tabHorse"), true);
            this._artifactTab = new BaseButton(getDisplayChildByName("tabArtifact"), true);
            this._magicBookTab = new BaseButton(getDisplayChildByName("tabMagicBook"), true);
            this._tabBtns.x = this._masterTab.x;
            this._tabBtns.y = this._masterTab.y;
            this._tabBtns.add(this._masterTab);
            this._tabBtns.add(this._horseTab);
            this._tabBtns.add(this._artifactTab);
            this._tabBtns.add(this._magicBookTab);
            this._tabBtns.addEvtListener(Event.CHANGE, this.__change);
            this._index = getIndexByName("close_btn");
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this.txt_title = getDisplayChildByName("txt_title");
            this._roleView = new OtherRoleMainView(getDisplayChildByName("role"));
            addChild(this._tabBtns);
            if (this._type == ROLE)
            {
                this._tabBtns.setSelectBtn(this._masterTab);
            }
            else if (this._type == HORSE)
            {
                this._tabBtns.setSelectBtn(this._horseTab);
            }
            else if (this._type == ARTIFACT)
            {
                this._tabBtns.setSelectBtn(this._artifactTab);
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        public function reqData(param1:long = null) : void
        {
            if (UILoaded)
            {
                if (this._type == ROLE)
                {
                    this._tabBtns.setSelectBtn(this._masterTab);
                    OtherRoleControl.getInstance().reqOtherPlayerInfo();
                }
                else if (this._type == HORSE)
                {
                    this._tabBtns.setSelectBtn(this._horseTab);
                    OtherRoleControl.getInstance().reqOtherPlayerHorse();
                }
                else if (this._type == ARTIFACT)
                {
                    this._tabBtns.setSelectBtn(this._artifactTab);
                    OtherRoleControl.getInstance().reqOtherPlayerInfo();
                }
                else if (this._type == MAGICBOOK && param1)
                {
                    this._tabBtns.setSelectBtn(this._magicBookTab);
                    OtherRoleControl.getInstance().reqOtherPlayerInfo();
                    MagicBookControl.getIntance().reqSeeOtherMagicbook(param1);
                }
            }
            return;
        }// end function

        private function __change(event:Event) : void
        {
            if (event.target.selectBtn == this._masterTab)
            {
                this._type = ROLE;
            }
            else if (event.target.selectBtn == this._horseTab)
            {
                this._type = HORSE;
            }
            else if (event.target.selectBtn == this._artifactTab)
            {
                this._type = ARTIFACT;
            }
            else if (event.target.selectBtn == this._magicBookTab)
            {
                this._type = MAGICBOOK;
            }
            this.updateUI();
            return;
        }// end function

        public function updateUI() : void
        {
            if (!UILoaded)
            {
                return;
            }
            switch(this._type)
            {
                case ROLE:
                {
                    this._roleView.visible = true;
                    this._roleView.info = OtherRoleControl.getInstance().playerInfo;
                    this._roleView.updateUI();
                    OtherRoleControl.getInstance().removeHorse();
                    OtherRoleControl.getInstance().removeMagicBook();
                    OtherRoleControl.getInstance().removeArtifact();
                    this.txt_title.text = LanguageCfgObj.getInstance().getByIndex("12451");
                    break;
                }
                case HORSE:
                {
                    this._roleView.visible = false;
                    OtherRoleControl.getInstance().addHorse();
                    OtherRoleControl.getInstance().removeMagicBook();
                    OtherRoleControl.getInstance().removeArtifact();
                    this.txt_title.text = LanguageCfgObj.getInstance().getByIndex("12452");
                    break;
                }
                case ARTIFACT:
                {
                    this._roleView.visible = false;
                    OtherRoleControl.getInstance().addArtifact();
                    OtherRoleControl.getInstance().removeMagicBook();
                    OtherRoleControl.getInstance().removeHorse();
                    OtherRoleControl.getInstance().otherArtifactView.update();
                    this.txt_title.text = LanguageCfgObj.getInstance().getByIndex("12453");
                    break;
                }
                case MAGICBOOK:
                {
                    this._roleView.visible = false;
                    this._roleView.info = OtherRoleControl.getInstance().playerInfo;
                    OtherRoleControl.getInstance().addMagicBook();
                    OtherRoleControl.getInstance().removeArtifact();
                    OtherRoleControl.getInstance().removeHorse();
                    MagicBookControl.getIntance().reqSeeOtherMagicbook(this._roleView.info.personId);
                    this.txt_title.text = LanguageCfgObj.getInstance().getByIndex("12454");
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.updateBtnName();
            return;
        }// end function

        public function createRemarkTips() : void
        {
            if (this._roleView)
            {
                this._roleView.createRemarkTips();
            }
            return;
        }// end function

        private function updateBtnName() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this.playInfo)
            {
                return;
            }
            var _loc_1:* = RoleLevelUtil.getMasterLevel(this.playInfo.level);
            var _loc_2:* = this.getPlayerName() + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_1]);
            this._masterTab.setText(_loc_2);
            this._horseTab.visible = false;
            if (this.playInfo.horseInfo)
            {
                this._horseTab.visible = true;
                _loc_3 = this.playInfo.horseInfo.horse_level;
                _loc_4 = HorseControl.getInstance().getHorseInfo(_loc_3);
                if (_loc_4)
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10095") + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_4.horse_step, _loc_4.horse_step_level]);
                }
                this._horseTab.setText(_loc_2);
            }
            this._artifactTab.visible = false;
            if (this.playInfo.artifact > 0)
            {
                this._artifactTab.visible = true;
                _loc_5 = ArtifactPropertyCfgObj.getInstance().getCfg(this.playInfo.artifact);
                _loc_2 = LanguageCfgObj.getInstance().getByIndex("12170") + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_5.q_step, _loc_5.q_client_level]);
                this._artifactTab.setText(_loc_2);
            }
            else
            {
                this._artifactTab.visible = false;
            }
            if (!this.playInfo.horseInfo)
            {
                this._artifactTab.move(0, 55);
            }
            else
            {
                this._artifactTab.move(0, 114);
            }
            if (this.playInfo.magicBook)
            {
                this._magicBookTab.move(0, 172);
                this._magicBookTab.visible = true;
                _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10010", MagicBookControl.MAGICBOOK_LANG), [this.playInfo.magicBook.getMagicStar(), this.playInfo.magicBook.getMagicLevel()]);
                this._magicBookTab.setText(_loc_2);
            }
            else
            {
                this._magicBookTab.visible = false;
            }
            return;
        }// end function

        private function getPlayerName() : String
        {
            if (!this.playInfo.name)
            {
                return "";
            }
            var _loc_1:* = this.playInfo.name.indexOf(".");
            return this.playInfo.name.substr((_loc_1 + 1));
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
