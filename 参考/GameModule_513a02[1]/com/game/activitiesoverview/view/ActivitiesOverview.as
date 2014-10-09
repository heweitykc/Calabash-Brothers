package com.game.activitiesoverview.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.activitiesoverview.control.*;
    import com.game.activitiesoverview.view.item.*;
    import com.game.prompt.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class ActivitiesOverview extends Component
    {
        private var _control:ActivitiesOverviewControl;
        private var _btnEffect:Dictionary;
        private var _activityStripe:Stripe;
        private var _ironChest:BaseButton;
        private var _copperChest:BaseButton;
        private var _sliverChest:BaseButton;
        private var _goldChest:BaseButton;
        private var _eventList:List;
        private var _arrayBox:Array;
        private var _boxInfo:Vector.<RewardBoxInfo>;
        private var _info:Vector.<LivenessEventInfo>;
        private var _liveness:int;
        private var _valueTxt:TextField;
        private var _tipsTxt:TextField;
        private var _unfinishTxt:TextField;
        private var _chestCfgArray:Array;
        private var _effect:Dictionary;
        private static var MAXSPRITEVALUE:int = 95;
        private static var numEvent:int = LivenessEventCfgObj.getInstance().getCount();

        public function ActivitiesOverview()
        {
            this._effect = new Dictionary();
            x = 4;
            y = 4;
            this._btnEffect = new Dictionary();
            ActivitiesOverviewControl.getInstance().activitiesoverview = this;
            this._control = ActivitiesOverviewControl.getInstance();
            super.initComponentUI("signup.activitiesoverview");
            this.initUI();
            this.addlistener();
            return;
        }// end function

        public function get liveness() : int
        {
            return this._liveness;
        }// end function

        public function set liveness(param1:int) : void
        {
            this._liveness = param1;
            this._valueTxt.text = this._liveness.toString();
            this.updateBox();
            this._activityStripe.setValue(param1, MAXSPRITEVALUE);
            return;
        }// end function

        public function get info() : Vector.<LivenessEventInfo>
        {
            return this._info;
        }// end function

        public function set info(param1:Vector.<LivenessEventInfo>) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get boxInfo() : Vector.<RewardBoxInfo>
        {
            return this._boxInfo;
        }// end function

        public function set boxInfo(param1:Vector.<RewardBoxInfo>) : void
        {
            this._boxInfo = param1;
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this._chestCfgArray = [];
            var _loc_1:* = LivenessBoxCfgObj.getInstance().getType();
            this._goldChest = new BaseButton(getDisplayChildByName("mc_gold"));
            this._sliverChest = new BaseButton(getDisplayChildByName("mc_sliver"));
            this._copperChest = new BaseButton(getDisplayChildByName("mc_copper"));
            this._ironChest = new BaseButton(getDisplayChildByName("mc_iron"));
            this._ironChest.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11863"), [_loc_1[0]]));
            this._arrayBox = [];
            this._arrayBox.push(this._ironChest);
            this._arrayBox.push(this._copperChest);
            this._arrayBox.push(this._sliverChest);
            this._arrayBox.push(this._goldChest);
            this._activityStripe = new Stripe("signup.stripe", "", "stripe_mask");
            this._unfinishTxt = getDisplayChildByName("unfinishTxt");
            this._activityStripe.x = 5;
            this._activityStripe.y = 90;
            addChild(this._activityStripe);
            var _loc_2:* = 0;
            while (_loc_2 < 4)
            {
                
                _loc_3 = LivenessBoxCfgObj.getInstance().getBoxById((_loc_2 + 1));
                this._chestCfgArray.push(_loc_3);
                this._arrayBox[_loc_2].setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11863"), [_loc_3.condition]));
                _loc_2++;
            }
            MAXSPRITEVALUE = this._chestCfgArray[3].condition;
            this._valueTxt = getDisplayChildByName("txt_value");
            this._tipsTxt = getDisplayChildByName("txt_tips");
            this._eventList = new List(210, 235);
            this._eventList.cellRenderer = OverViewItem;
            this._eventList.move(9, 196);
            addChild(this._eventList);
            return;
        }// end function

        private function showTip() : void
        {
            return;
        }// end function

        private function addlistener() : void
        {
            this._ironChest.addEvtListener(MouseEvent.CLICK, this.__chestClick);
            this._copperChest.addEvtListener(MouseEvent.CLICK, this.__chestClick);
            this._sliverChest.addEvtListener(MouseEvent.CLICK, this.__chestClick);
            this._goldChest.addEvtListener(MouseEvent.CLICK, this.__chestClick);
            addEventListener(MouseEvent.MOUSE_OVER, this.__filter);
            addEventListener(MouseEvent.MOUSE_OUT, this.__filter);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function __filter(event:MouseEvent) : void
        {
            var _loc_2:* = this._arrayBox.indexOf(event.target);
            if (_loc_2 != -1 && this._control.getBoxState((_loc_2 + 1)) == 1)
            {
                StringTip.create(event.target as DisplayObject, LanguageCfgObj.getInstance().getByIndex("10195"));
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            ActivitiesOverviewControl.getInstance().reqBox();
            ActivitiesOverviewControl.getInstance().reqEvent();
            ActivitiesOverviewControl.getInstance().reqliveness();
            return;
        }// end function

        private function __chestClick(event:MouseEvent) : void
        {
            var _loc_2:* = this._arrayBox.indexOf(event.target);
            if (_loc_2 != -1)
            {
                if (this._liveness < this._chestCfgArray[_loc_2].condition)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10196"));
                    return;
                }
                ActivitiesOverviewControl.getInstance().gainBox((_loc_2 + 1));
            }
            return;
        }// end function

        public function gainBoxSuc(param1:int) : void
        {
            var _loc_4:* = null;
            this.addOrRemoveEffect(false, this._arrayBox[param1]);
            (this._arrayBox[param1] as BaseButton).filters = [FrameworkGlobal.colorMat];
            var _loc_2:* = [];
            var _loc_3:* = (this._arrayBox[param1] as BaseButton).localToGlobal(new Point(0, 0));
            for each (_loc_4 in this._chestCfgArray[param1].goods)
            {
                
                _loc_2.push(_loc_4.itemModelId);
                ItemGetAnim.doFlyToBackPack(_loc_4.itemModelId, _loc_3, 1.5);
            }
            return;
        }// end function

        public function updateItem(param1:int, param2:int) : void
        {
            if (!this._eventList)
            {
                return;
            }
            var _loc_3:* = this._eventList.search("type_id", param1);
            if (!_loc_3)
            {
                return;
            }
            (_loc_3 as OverViewItem).update(param2);
            return;
        }// end function

        public function updateEvent() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this._eventList.reset();
            if (UILoaded)
            {
                _loc_1 = 0;
                _loc_3 = 1;
                while (_loc_3 <= numEvent)
                {
                    
                    _loc_4 = new LivenessInfo();
                    _loc_4.prase(LivenessEventCfgObj.getInstance().getEventById(_loc_3));
                    _loc_4.times = this._control.getEventCout(_loc_3);
                    if (_loc_4.times < _loc_4.q_count)
                    {
                        _loc_1 = _loc_1 + 1;
                    }
                    _loc_2 = new OverViewItem();
                    _loc_2.index = _loc_3;
                    _loc_2.obj = _loc_4;
                    this._eventList.add(_loc_2, true);
                    _loc_3++;
                }
                this._unfinishTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11864"), [_loc_1]);
            }
            return;
        }// end function

        public function addOrRemoveEffect(param1:Boolean, param2:BaseButton) : void
        {
            var _loc_3:* = null;
            if (!param2)
            {
                throw new Error("参数btn不能为空");
            }
            if (param1 && !this._btnEffect[param2])
            {
                _loc_3 = new VMCView();
                _loc_3.auto = true;
                _loc_3.loadRes("res/effect/changejob/ball.png", null, true);
                _loc_3.updatePose("90", true);
                _loc_3.move(24, 20);
                param2.addChild(_loc_3);
                this._btnEffect[param2] = _loc_3;
            }
            else if (!param1 && this._btnEffect[param2])
            {
                _loc_3 = this._btnEffect[param2];
                param2.removeChild(_loc_3);
                _loc_3.finalize();
                delete this._btnEffect[param2];
            }
            return;
        }// end function

        public function updateBox() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (UILoaded)
            {
                _loc_1 = 0;
                while (_loc_1 < this._arrayBox.length)
                {
                    
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10197");
                    if (this._control.getBoxState((_loc_1 + 1)) == 1)
                    {
                        this._arrayBox[_loc_1].filters = [FrameworkGlobal.colorMat];
                        this.addOrRemoveEffect(false, this._arrayBox[_loc_1]);
                        StringTip.create(this._arrayBox[_loc_1], LanguageCfgObj.getInstance().getByIndex("10195"));
                    }
                    else
                    {
                        this._arrayBox[_loc_1].filters = null;
                        if (this._liveness >= this._chestCfgArray[_loc_1].condition)
                        {
                            this.addOrRemoveEffect(true, this._arrayBox[_loc_1]);
                        }
                        else
                        {
                            this.addOrRemoveEffect(false, this._arrayBox[_loc_1]);
                        }
                        _loc_3 = LivenessBoxCfgObj.getInstance().getBoxById((_loc_1 + 1));
                        for each (_loc_4 in _loc_3.goods)
                        {
                            
                            _loc_2 = _loc_2 + ("<font color=\'#fcf600\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11865"), [ItemCfgObj.getInstance().getCfgBy(_loc_4.itemModelId).q_name, _loc_4.num]) + "</font><br/>");
                        }
                        StringTip.create(this._arrayBox[_loc_1], _loc_2);
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function getUnfinishedNum() : int
        {
            return 1;
        }// end function

    }
}
