package com.game.awardGuide.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.awardGuide.control.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class ItemAwardPanel extends BaseBox implements IGuide
    {
        private var _info:PropInfo;
        private var _curNum:int;
        private var _layoutInfo:LayoutInfo;
        private var _needArrowGuide:Boolean;
        private var _maxNum:int;
        public var isGuideUseItemPanel:Boolean = false;
        private var _icon:IconItem;
        private var _closeBtn:BaseButton;
        private var _okBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _upBtn:BaseButton;
        private var _downBtn:BaseButton;
        private var _maxBtn:BaseButton;
        protected var _nameTxt:TextField;
        protected var _numTxt:TextField;

        public function ItemAwardPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            setWH(250, 179);
            loadDisplay("res/itemawardguide.swf");
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            if (this._info)
            {
                if (this._info.q_whether_batch)
                {
                    this._maxNum = this._info.num;
                }
                else
                {
                    this._maxNum = 1;
                }
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("item_get_box");
            this.initUI();
            this.updateView();
            super.displayReady();
            return;
        }// end function

        protected function initUI() : void
        {
            this._icon = new IconItem("");
            this._icon.setWH(40, 40);
            this._icon.move(30, 74);
            addChild(this._icon);
            this._okBtn = new BaseButton(getDisplayChildByName("ok_btn"));
            this._closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("cancel_btn"));
            this._upBtn = new BaseButton(getDisplayChildByName("up_btn"));
            this._downBtn = new BaseButton(getDisplayChildByName("down_btn"));
            this._maxBtn = new BaseButton(getDisplayChildByName("max_btn"));
            this._nameTxt = getDisplayChildByName("nameTxt");
            this._numTxt = getDisplayChildByName("numTxt");
            this._numTxt.maxChars = 4;
            this._numTxt.restrict = "0-9";
            this._nameTxt.type = TextFieldType.INPUT;
            this.addListener();
            return;
        }// end function

        private function addListener() : void
        {
            this._closeBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._okBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._upBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._downBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._maxBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._cancelBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._numTxt.addEventListener(Event.CHANGE, this._numChangeHandler);
            return;
        }// end function

        private function _clickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            switch(event.currentTarget)
            {
                case this._okBtn:
                {
                    if (!this._info)
                    {
                        this.close();
                        return;
                    }
                    if (this.isGuideUseItemPanel)
                    {
                        ClickStream.quickUseItem(this._info.q_id);
                    }
                    _loc_2 = int(this._numTxt.text);
                    _loc_3 = BackpackObj.getInstance().getItemById(this._info.itemId);
                    if (_loc_2 > _loc_3.num)
                    {
                        _loc_2 = _loc_3.num;
                    }
                    if (_loc_2 != 0 && _loc_3 != null)
                    {
                        BackPackControl.getInstance().useItem(_loc_3, int(_loc_2));
                    }
                    this.removeGuide();
                    this.close();
                    break;
                }
                case this._upBtn:
                {
                    var _loc_4:* = this;
                    var _loc_5:* = this.curNum + 1;
                    _loc_4.curNum = _loc_5;
                    break;
                }
                case this._downBtn:
                {
                    var _loc_4:* = this;
                    var _loc_5:* = this.curNum - 1;
                    _loc_4.curNum = _loc_5;
                    break;
                }
                case this._maxBtn:
                {
                    this.curNum = this._info.num;
                    break;
                }
                case this._closeBtn:
                case this._cancelBtn:
                {
                    this.removeGuide();
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function _numChangeHandler(event:Event) : void
        {
            var _loc_2:* = this._numTxt.text;
            if (_loc_2 != "")
            {
                this.curNum = int(_loc_2);
            }
            return;
        }// end function

        protected function openPanel() : void
        {
            if (!this._layoutInfo)
            {
                this._layoutInfo = new LayoutInfo(Layout.CENTER, 300, 0);
            }
            Global.popManager.addUI(this, this._layoutInfo);
            this.updateView();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.openPanel();
            return;
        }// end function

        protected function closePanel() : void
        {
            TweenLite.killDelayedCallsTo(this.clickOk);
            Global.popManager.removeUI(this);
            this._info = null;
            this.guideEnd(GuideConfigObj.getInstance().TASK_ITEM_AWARD_GUIDE_ID_1);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.closePanel();
            return;
        }// end function

        protected function updateView() : void
        {
            var _loc_1:* = null;
            if (UILoaded && this._info)
            {
                if (this._info.q_whether_batch)
                {
                    this._maxNum = this._info.num;
                }
                else
                {
                    this._maxNum = 1;
                }
                _loc_1 = PropUtil.getEquipNameAndColor(this._info);
                this._nameTxt.text = _loc_1[0];
                this._nameTxt.textColor = _loc_1[1];
                this.curNum = this._maxNum;
                this._icon.setInfo(this._info);
                this._icon.count = this._maxNum;
                if (this._needArrowGuide)
                {
                    this.registerGuide();
                    GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().TASK_ITEM_AWARD_TEAM));
                }
                if (UserObj.getInstance().playerInfo.level <= 70)
                {
                    TweenLite.delayedCall(TaskGlobal.AUTO_ITEM_AWARD_OK, this.clickOk);
                }
            }
            return;
        }// end function

        private function clickOk() : void
        {
            if (this._okBtn)
            {
                this._okBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        private function removeGuide() : void
        {
            if (this._info)
            {
                ItemAwardGuideControl.getInstance().removeGuide(this._info);
            }
            return;
        }// end function

        public function get curNum() : int
        {
            return this._curNum;
        }// end function

        public function set curNum(param1:int) : void
        {
            this._curNum = param1;
            if (this._curNum > this._maxNum)
            {
                this._curNum = this._maxNum;
            }
            if (this._curNum <= 0)
            {
                this._curNum = 1;
            }
            if (this._numTxt)
            {
                this._numTxt.text = this._curNum.toString();
            }
            return;
        }// end function

        public function get needArrowGuide() : Boolean
        {
            return this._needArrowGuide;
        }// end function

        public function set needArrowGuide(param1:Boolean) : void
        {
            this._needArrowGuide = param1;
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this._okBtn, this, GuideConfigObj.getInstance().TASK_ITEM_AWARD_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            this._needArrowGuide = false;
            GuideMultiControl.getInstance().unregisterGuide(this._okBtn, param1);
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
