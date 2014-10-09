package com.game.primaryrole.view
{
    import avmplus.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.artifact.event.*;
    import com.game.artifact.model.*;
    import com.game.clickstream.*;
    import com.game.elementHeart.control.*;
    import com.game.elementHeart.event.*;
    import com.game.elementHeart.model.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.horse.control.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.game.primaryrole.control.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class PrimaryRoleMainPanel extends BaseBox implements IGuide
    {
        private var _masterTab:BaseButton;
        private var _servantTab:BaseButton;
        private var _horseTab:BaseButton;
        private var _artifactTab:BaseButton;
        private var _magicBookTab:BaseButton;
        private var _elementTab:BaseButton;
        private var _roleView:PrimaryRoleMainView;
        private var _titleTxt:TextField;
        private var _icon_cloth:Object;
        private var closeBtn:BaseButton;
        private var _labelContainer:Sprite;
        private var _roleInfo:PlayerInfo;
        private var _tabBtns:Buttons;
        private var _type:String;
        public static const HORSE:String = "horse";
        public static const ROLE:String = "role";
        public static const ARTIFACT:String = "artifact";
        public static const ARTIFACT_EXTRACT:String = "artifactExtract";
        public static const MAGIC_BOOK:String = "magicBook";
        public static const ELEMENT_HEART:String = "element";

        public function PrimaryRoleMainPanel()
        {
            _combinedBox = ["com.game.primaryrole.view::RoleInfoPanel", "com.game.primaryrole.view::RoleTalentPlusPanel", "com.game.backpack.view::BackPackPanel", "com.game.horse.view::HorseUpScanView", "com.game.artifact.view::ArtifactExtractPanel", "com.game.jilifer.view::JiliferPanel", "com.game.primaryrole.view::TitleViewPanel", "com.game.elementHeart.view::ElementHousePanel"];
            loadDisplay("res/primaryrole.swf");
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

        override protected function displayReady() : void
        {
            initBaseBoxUI("primaryrolepanel");
            this.initUI();
            this._roleInfo = UserObj.getInstance().playerInfo;
            this.addListener();
            super.displayReady();
            this.updateUI();
            this.guideConfigComplete();
            this.registerGuide();
            return;
        }// end function

        private function addListener() : void
        {
            this._roleInfo.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__levelChange);
            GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            ArtifactData.getInstance().addEventListener(ArtifactEvent.ARTIFACT_DATA_CHANGE, this.dealArtifact);
            MagicBookData.getMagicBookInfo().addEvtListener(MagicBookEvent.UPDATEINFO, this.dealMagicBook);
            return;
        }// end function

        private function initUI() : void
        {
            this._tabBtns = new Buttons();
            this._masterTab = new BaseButton(getDisplayChildByName("tabMaster"), true);
            this._masterTab.setWH(114, 49);
            this._horseTab = new BaseButton(getDisplayChildByName("tabHorse"), true);
            this._horseTab.setWH(114, 49);
            this._artifactTab = new BaseButton(getDisplayChildByName("tabArtifact"), true);
            this._artifactTab.setWH(114, 49);
            this._magicBookTab = new BaseButton(getDisplayChildByName("tabMagicBook"), true);
            this._magicBookTab.setWH(114, 49);
            this._elementTab = new BaseButton(getDisplayChildByName("tabElement"), true);
            this._elementTab.setWH(114, 49);
            this._tabBtns.x = this._masterTab.x;
            this._tabBtns.y = this._masterTab.y;
            this._tabBtns.add(this._masterTab);
            this._tabBtns.add(this._horseTab);
            this._tabBtns.add(this._artifactTab);
            this._tabBtns.add(this._magicBookTab);
            this._tabBtns.add(this._elementTab);
            this._tabBtns.addEvtListener(Event.CHANGE, this.__change);
            this._titleTxt = getDisplayChildByName("txt_title");
            this._labelContainer = getDisplayChildByName("labelcontainer");
            this._labelContainer.mouseEnabled = false;
            addChild(this._labelContainer);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            addChild(this.closeBtn);
            this._roleView = new PrimaryRoleMainView(getDisplayChildByName("role"));
            var _loc_1:* = RoleLevelUtil.getMasterLevel(UserObj.getInstance().playerInfo.level);
            var _loc_2:* = ToolKit.trimDistrict(UserObj.getInstance().playername) + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_1]);
            this._masterTab.setText(_loc_2);
            this.dealHorse();
            this.dealArtifact();
            this.dealMagicBook();
            this.dealElement();
            display.addChild(this._tabBtns);
            if (this._type == ROLE)
            {
                this._tabBtns.doBtnClick(this._masterTab);
            }
            else if (this._type == HORSE && this._horseTab.visible)
            {
                this._tabBtns.doBtnClick(this._horseTab);
            }
            else if ((this._type == ARTIFACT || this._type == ARTIFACT_EXTRACT) && this._artifactTab.visible)
            {
                this._tabBtns.doBtnClick(this._artifactTab);
            }
            else if (this._type == MAGIC_BOOK && this._magicBookTab.visible)
            {
                this._tabBtns.doBtnClick(this._magicBookTab);
            }
            else if (this._type == ELEMENT_HEART)
            {
                this._tabBtns.doBtnClick(this._elementTab);
            }
            return;
        }// end function

        public function dealHorse() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (UserObj.getInstance().playerInfo.horseInfo)
            {
                _loc_1 = UserObj.getInstance().playerInfo.horseInfo.horse_level;
                _loc_2 = HorseControl.getInstance().getHorseInfo(_loc_1);
                if (_loc_2)
                {
                    _loc_3 = LanguageCfgObj.getInstance().getByIndex("10095") + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_2.horse_step, _loc_2.horse_step_level]);
                }
                this._horseTab.setText(_loc_3);
                this._horseTab.visible = true;
            }
            else
            {
                this._horseTab.visible = false;
            }
            return;
        }// end function

        public function dealArtifact(event:Event = null) : void
        {
            if (ArtifactData.getInstance().isArtifactEnabled())
            {
                this.setArtifactGateInfo();
                this._artifactTab.visible = true;
            }
            else
            {
                this._artifactTab.visible = false;
            }
            return;
        }// end function

        public function dealMagicBook(event:Event = null) : Boolean
        {
            if (MagicBookData.hasOpenMagicBook())
            {
                this._magicBookTab.visible = true;
                this.setMagicBookInfo();
                return true;
            }
            this._magicBookTab.visible = false;
            return false;
        }// end function

        private function dealElement(event:Event = null) : void
        {
            if (ElementHeartData.getInstance().enable())
            {
                this._elementTab.visible = true;
                ElementHeartData.getInstance().addEvtListener(EHeartEvent.CHANGE_VALUE, this.setElementInfo);
                this.setElementInfo();
            }
            else
            {
                ElementHeartData.getInstance().removeEvtListener(EHeartEvent.CHANGE_VALUE, this.setElementInfo);
                this._elementTab.visible = false;
            }
            return;
        }// end function

        private function __levelChange(event:RoleEvent) : void
        {
            var _loc_2:* = RoleLevelUtil.getMasterLevel(UserObj.getInstance().playerInfo.level);
            var _loc_3:* = ToolKit.trimDistrict(UserObj.getInstance().playerInfo.name) + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_2]);
            this._masterTab.setText(_loc_3);
            this.dealMagicBook(null);
            this.dealElement(null);
            return;
        }// end function

        public function setWaterLight(param1:uint, param2:Number) : void
        {
            this._roleView.setWaterLight(param1, param2);
            return;
        }// end function

        public function setHorseGateInfo() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.horseInfo.horse_level;
            var _loc_2:* = HorseControl.getInstance().getHorseInfo(_loc_1);
            if (_loc_2)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10095") + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_2.horse_step, _loc_2.horse_step_level]);
            }
            this._horseTab.setText(_loc_3);
            return;
        }// end function

        public function setArtifactGateInfo(event:Event = null) : void
        {
            var _loc_2:* = ArtifactData.getInstance();
            var _loc_3:* = LanguageCfgObj.getInstance().getByIndex("12170") + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_2.steplv, _loc_2.stepInnerLv]);
            this._artifactTab.setText(_loc_3);
            return;
        }// end function

        public function setMagicBookInfo(event:Event = null) : void
        {
            var _loc_2:* = MagicBookData.getMagicBookInfo();
            var _loc_3:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10010", MagicBookControl.MAGICBOOK_LANG), [_loc_2.getMagicStar(), _loc_2.getMagicLevel()]);
            this._magicBookTab.setText(_loc_3);
            return;
        }// end function

        public function setElementInfo(event:Event = null) : void
        {
            var _loc_2:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1001", ElementHeartControl.LANG)) + "<br/>" + ElementHeartData.getInstance().value;
            this._elementTab.setText(_loc_2);
            return;
        }// end function

        private function getPlayerName() : String
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.name.indexOf("]");
            return UserObj.getInstance().playerInfo.name.substr((_loc_1 + 1));
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                if (this._type == ROLE)
                {
                    this._tabBtns.doBtnClick(this._masterTab);
                }
                else if (this._type == HORSE)
                {
                    this._tabBtns.doBtnClick(this._horseTab);
                }
                else if (this._type == ARTIFACT || this._type == ARTIFACT_EXTRACT)
                {
                    this._tabBtns.doBtnClick(this._artifactTab);
                }
                else if (this._type == MAGIC_BOOK)
                {
                    this._tabBtns.doBtnClick(this._magicBookTab);
                }
                else if (this.type == ELEMENT_HEART)
                {
                    this._tabBtns.doBtnClick(this._elementTab);
                }
                this.updateUI();
            }
            return;
        }// end function

        private function __change(event:Event) : void
        {
            var _loc_2:* = this._type;
            if (event.target.selectBtn == this._masterTab)
            {
                this._type = ROLE;
            }
            else if (event.target.selectBtn == this._servantTab)
            {
                this._type = HORSE;
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
                this._type = MAGIC_BOOK;
            }
            else if (event.target.selectBtn == this._elementTab)
            {
                this._type = ELEMENT_HEART;
            }
            if (_loc_2 == this._type)
            {
                return;
            }
            if (_loc_2 == ELEMENT_HEART)
            {
                ElementHeartControl.getInstance().closeElementHousePanel();
            }
            this.updateUI();
            return;
        }// end function

        protected function updateUI() : void
        {
            switch(this._type)
            {
                case ROLE:
                {
                    this.closeTabs(this._type);
                    this._roleView.visible = true;
                    this._roleView.info = UserObj.getInstance().playerInfo;
                    this._roleView.updateUI();
                    this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11044");
                    break;
                }
                case HORSE:
                {
                    this.closeTabs(this._type);
                    PrimaryRoleControl.getInstance().addHorse();
                    ClickStream.add(ClickStreamId.OPEN_ZuoQi);
                    this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11045");
                    break;
                }
                case ARTIFACT:
                {
                    this.closeTabs(this._type);
                    PrimaryRoleControl.getInstance().addArtifact();
                    this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11046");
                    break;
                }
                case ARTIFACT_EXTRACT:
                {
                    this.closeTabs(this._type);
                    PrimaryRoleControl.getInstance().addArtifactExtract();
                    this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11046");
                    break;
                }
                case MAGIC_BOOK:
                {
                    this.closeTabs(this._type);
                    PrimaryRoleControl.getInstance().addMagicBook();
                    this._titleTxt.htmlText = "<b>" + LanguageCfgObj.getInstance().getByIndex("10001", MagicBookControl.MAGICBOOK_LANG) + "</b>";
                    break;
                }
                case ELEMENT_HEART:
                {
                    this.closeTabs(this._type);
                    PrimaryRoleControl.getInstance().addElementHeart();
                    this._titleTxt.htmlText = "<b>" + LanguageCfgObj.getInstance().getByIndex("eh1001", ElementHeartControl.LANG) + "</b>";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function closeTabs(param1:String) : void
        {
            if (param1 != ROLE)
            {
                this._roleView.visible = false;
                PrimaryRoleControl.getInstance().closeInfo();
            }
            if (param1 != HORSE)
            {
                PrimaryRoleControl.getInstance().removeHorse();
            }
            if (param1 != ARTIFACT && param1 != ARTIFACT_EXTRACT)
            {
                PrimaryRoleControl.getInstance().removeArtifact();
            }
            if (param1 != MAGIC_BOOK)
            {
                PrimaryRoleControl.getInstance().removeMagicBookView();
            }
            if (param1 != ELEMENT_HEART)
            {
                PrimaryRoleControl.getInstance().removeElementHeartView();
            }
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            PrimaryRoleControl.getInstance().openPrimayRoleMain();
            this.close();
            return;
        }// end function

        public function addDisplay(param1:DisplayObject) : void
        {
            display.addChildAt(param1, display.numChildren);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            this.guidePause(GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_3);
            this.guidePause(GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_4);
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        private function guideConfigComplete(event:GuideEvent = null) : void
        {
            GuideConfigObj.getInstance().removeEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().HORSE_ACTIVE_TEAM)) == 0 && this._horseTab)
            {
                this._horseTab.visible = false;
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM)) == 0 && this._artifactTab)
            {
                this._artifactTab.visible = false;
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
            }
            return;
        }// end function

        private function guideActive(event:GuideEvent) : void
        {
            var _loc_2:* = String(event.data);
            if (_loc_2 == GuideConfigObj.getInstance().HORSE_ACTIVE_TEAM)
            {
                this._horseTab.visible = true;
            }
            if (_loc_2 == GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM)
            {
                this._artifactTab.visible = true;
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this.closeBtn, this, GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_3);
            GuideMultiControl.getInstance().registerGuide(this.closeBtn, this, GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_4);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function createAttributeTips() : void
        {
            if (this._roleView)
            {
                this._roleView.createAttributeTips();
            }
            return;
        }// end function

        public function checkEquip() : void
        {
            if (this._roleView)
            {
                this._roleView.checkEquip();
            }
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            if (param1)
            {
                GuideMultiControl.getInstance().backGuide(param1, 1);
            }
            else
            {
                GuideControl.getInstance().backGuide(param1, 1);
            }
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded && isOpen;
        }// end function

    }
}
