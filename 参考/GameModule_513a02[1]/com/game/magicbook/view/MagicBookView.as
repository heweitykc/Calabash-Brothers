package com.game.magicbook.view
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.f1.vmc.*;
    import com.game.challenge.view.component.*;
    import com.game.goldRaffle.view.component.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.game.magicbook.view.compent.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class MagicBookView extends Component
    {
        private var _magicBookPhoto:VMCView;
        private var _magicBookText:Image;
        private var _magicNum:NumberMc;
        private var _skillboxes:HBox;
        private var _btnRightRot:BaseButton;
        private var _btnLeftRot:BaseButton;
        private var _btnScanInfo:BaseButton;
        private var _starH:HBox;
        private var _tab1Btn:BaseButton;
        private var _tab2Btn:BaseButton;
        private var _tabMan:TabManager;
        private var _magicBookInfo:MagicBookInfo;
        private var _currentMagicCfg:QMagicBookCfg;
        private var _nextModelBtn:BaseButton;
        private var _lastModelBtn:BaseButton;
        private var systemCue:ScrollSystemCue;
        public var falsh:Boolean = false;
        private var _modelDir:int = 3;
        public static var magicBookLang:String = "lang_magicBook";
        private static const STAR_NUM:int = 10;

        public function MagicBookView()
        {
            this._magicBookInfo = MagicBookData.getMagicBookInfo();
            loadDisplay("res/magicbookpanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("magicbook_main");
            super.displayReady();
            this.initUI();
            this.addEvent();
            this.updateUI();
            this.onAddedToStage();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            this._tab1Btn = new BaseButton(getDisplayChildByName("tab1Btn"), true);
            this._tab2Btn = new BaseButton(getDisplayChildByName("tab2Btn"), true);
            this._btnLeftRot = new BaseButton(getDisplayChildByName("btnLeftRot"));
            this._btnRightRot = new BaseButton(getDisplayChildByName("btnRightRot"));
            this._nextModelBtn = new BaseButton(getDisplayChildByName("nextModelBtn"));
            this._lastModelBtn = new BaseButton(getDisplayChildByName("lastModelBtn"));
            this._tab1Btn.setText(LanguageCfgObj.getInstance().getByIndex("10002", magicBookLang));
            this._tab2Btn.setText(LanguageCfgObj.getInstance().getByIndex("10003", magicBookLang));
            this._tab2Btn.visible = MagicBookData.isOpenGrowFunction;
            this._tabMan = new TabManager();
            this._tabMan.add(this._tab1Btn, MagicBookPropertyView);
            this._tabMan.add(this._tab2Btn, MagicBookGrowView);
            this._tabMan.selected = 0;
            addChild(this._tabMan);
            this._magicNum = new NumberMc("magicbook_num");
            this._magicNum.move(115, 341);
            addChild(this._magicNum);
            this._magicNum.visible = false;
            this._skillboxes = new HBox();
            this._skillboxes.horizontal = true;
            this._skillboxes.intervalX = 17;
            this._skillboxes.intervalY = 10;
            this._skillboxes.oneRow = 4;
            var _loc_2:* = 0;
            while (_loc_2 < 8)
            {
                
                _loc_1 = new MagicBookSkillBox();
                StringTip.create(_loc_1, "暂未开放，敬请期待");
                this._skillboxes.add(_loc_1);
                _loc_2++;
            }
            this._skillboxes.move(67, 403);
            addChild(this._skillboxes);
            this._starH = new HBox();
            this._starH.move(53, 74);
            this._starH.horizontal = true;
            this._starH.intervalX = 3;
            addChild(this._starH);
            var _loc_4:* = 0;
            while (_loc_4 < STAR_NUM)
            {
                
                _loc_3 = ToolKit.getNew("magicbook_star");
                this._starH.add(_loc_3);
                _loc_4++;
            }
            this._magicBookPhoto = new VMCView();
            this._magicBookPhoto.auto = true;
            this._magicBookPhoto.move(190, 300);
            addChild(this._magicBookPhoto);
            this.systemCue = new ScrollSystemCue(ScrollSystemCue.FIGHT_NOTICE);
            this.systemCue.move(656, 252);
            this.addChild(this.systemCue);
            return;
        }// end function

        private function setStarLight(param1:int, param2:int) : void
        {
            if (param1 > STAR_NUM && param1 < 1)
            {
                Log.error("MagicBook:" + param1 + "星星数组越界");
            }
            else
            {
                this.freshModelView(param1);
            }
            return;
        }// end function

        private function freshModelView(param1:int) : void
        {
            this._lastModelBtn.visible = param1 > this._magicBookInfo.getMagicStar();
            this._nextModelBtn.visible = param1 < STAR_NUM;
            if (param1 == this._magicBookInfo.getMagicStar())
            {
                this._currentMagicCfg = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._magicBookInfo.level);
                MagicBookControl.getIntance().showModelCompareTips(null);
            }
            else
            {
                this._currentMagicCfg = QMagicbookLevelCfg.getInstance().getMagicBookCfgByStar(param1);
                MagicBookControl.getIntance().showModelCompareTips(this._currentMagicCfg.prop);
            }
            var _loc_2:* = 0;
            while (_loc_2 < STAR_NUM)
            {
                
                if (_loc_2 < param1)
                {
                    (this._starH.getContent(_loc_2) as MovieClip).gotoAndStop(1);
                }
                else
                {
                    (this._starH.getContent(_loc_2) as MovieClip).gotoAndStop(2);
                }
                StringTip.create(this._starH.getContent(_loc_2), StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10010", MagicBookControl.MAGICBOOK_LANG), [this._magicBookInfo.getMagicStar(), this._magicBookInfo.getMagicLevel()]));
                _loc_2++;
            }
            this.loadModelRes();
            return;
        }// end function

        public function addToSystem(param1:String) : void
        {
            if (this.systemCue)
            {
                this.systemCue.addedScrollInfo(param1);
            }
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this._tabMan.addEventListener(Event.CHANGE, this.__tabChange);
            this.addEvtListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            this.addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function updateUI() : void
        {
            this._currentMagicCfg = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._magicBookInfo.level);
            this.__updateInfo();
            this.__updateSkillInfo();
            return;
        }// end function

        private function doBreakSuccessFlash(event:Event) : void
        {
            var _loc_2:* = new VMCView();
            addChild(_loc_2);
            _loc_2.loadRes("res/effect/magicbook/breaksucess.png");
            _loc_2.auto = true;
            _loc_2.updatePose("90", false, false, true, true);
            _loc_2.move(this._magicBookPhoto.x + 30, this._magicBookPhoto.y - 20);
            return;
        }// end function

        private function __updateInfo(event:MagicBookEvent = null) : void
        {
            if (this._magicBookInfo && UILoaded)
            {
                this._magicNum.setNumber(this._magicBookInfo.potential, this.falsh);
                this.freshModelView(this._magicBookInfo.getMagicStar());
            }
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            var _loc_2:* = (event.target as TabManager).index;
            MagicBookControl.getIntance().mouseOverCompareProp();
            return;
        }// end function

        public function addPropTips(param1:DisplayObject) : void
        {
            if (this._tabMan.index == 0)
            {
                this.addChild(param1);
            }
            else if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event = null) : void
        {
            this._magicBookInfo.addEvtListener(MagicBookEvent.UPDATEINFO, this.__updateInfo);
            this._magicBookInfo.addEvtListener(MagicBookEvent.SKILL_CHANGE, this.__updateSkillInfo);
            MagicBookData.addEventListener(MagicBookData.BREAK_SUCCESS, this.doBreakSuccessFlash);
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this._magicBookInfo.removeEvtListener(MagicBookEvent.UPDATEINFO, this.__updateInfo);
            this._magicBookInfo.removeEvtListener(MagicBookEvent.SKILL_CHANGE, this.__updateSkillInfo);
            MagicBookData.removeEventListener(MagicBookData.BREAK_SUCCESS, this.doBreakSuccessFlash);
            return;
        }// end function

        private function __updateSkillInfo(event:MagicBookEvent = null) : void
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_2:* = this._magicBookInfo.skills_m;
            var _loc_3:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                if (!_loc_2[_loc_5])
                {
                }
                else
                {
                    _loc_6 = MagicBookSkillCfgObj.getInstance().getMagicSkillInfoByServer(_loc_2[_loc_5]);
                    _loc_4 = this._skillboxes.getContent(_loc_5) as MagicBookSkillBox;
                    StringTip.dispose(_loc_4);
                    _loc_4.setInfo(_loc_6);
                }
                _loc_5++;
            }
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnLeftRot:
                {
                    this.setNestDirect(1);
                    break;
                }
                case this._btnRightRot:
                {
                    this.setNestDirect(-1);
                    break;
                }
                case this._lastModelBtn:
                {
                    this.freshModelView((this._currentMagicCfg.getStar() - 1));
                    break;
                }
                case this._nextModelBtn:
                {
                    this.freshModelView((this._currentMagicCfg.getStar() + 1));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setNestDirect(param1:int = 0) : void
        {
            if (!this._magicBookPhoto)
            {
                return;
            }
            switch(param1)
            {
                case -1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._modelDir - 1;
                    _loc_2._modelDir = _loc_3;
                    this._modelDir = this._modelDir < -3 ? (4) : (this._modelDir);
                    break;
                }
                case 0:
                {
                    break;
                }
                case 1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._modelDir + 1;
                    _loc_2._modelDir = _loc_3;
                    this._modelDir = this._modelDir > 4 ? (-3) : (this._modelDir);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.loadModelRes();
            return;
        }// end function

        public function loadModelRes() : void
        {
            var mbCfg:QMagicBookCfg;
            if (!this._currentMagicCfg)
            {
                mbCfg = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._magicBookInfo.level);
            }
            else
            {
                mbCfg = this._currentMagicCfg;
            }
            if (mbCfg)
            {
                if (this._magicBookPhoto)
                {
                    this._magicBookPhoto.direct = this._modelDir * 45;
                    this._magicBookPhoto.loadRes(mbCfg.panelModelUrl, null, false, function () : void
            {
                _magicBookPhoto.updatePose(Math.abs(_modelDir * 45).toString(), true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
