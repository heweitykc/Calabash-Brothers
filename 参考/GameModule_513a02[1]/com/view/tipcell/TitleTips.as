package com.view.tipcell
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.text.*;

    public class TitleTips extends BaseTips
    {
        private var _info:TitleVO;
        private var _timerId:String;
        private var _view:MovieClip;
        private var back:DisplayObject;
        private var vmcMc:MovieClip;
        private var _titleImg:VMCView;
        private var split1:DisplayObject;
        private var attributeTit:DisplayObject;
        private var attributeTf:TextField;
        private var split2:DisplayObject;
        private var lostTimeTf:TextField;
        private var split3:DisplayObject;
        private var descTf:TextField;
        private var tagItem:DisplayObject;

        public function TitleTips()
        {
            var _loc_1:* = false;
            tabEnabled = false;
            tabChildren = _loc_1;
            mouseEnabled = _loc_1;
            mouseChildren = _loc_1;
            this._view = ToolKit.getNew("titleUIPanel.tips");
            addChild(this._view);
            this.initUI();
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._info = param1 as TitleVO;
            if (this._info)
            {
                _loc_2 = this.split1.y;
                _loc_3 = TitleCfgObj.getInstance().getTitleById(this._info.titleid);
                if (this._titleImg.url != _loc_3.url)
                {
                    this._titleImg.updatePose("90", true, true);
                    this._titleImg.auto = true;
                    this._titleImg.loadRes(_loc_3.url, null, false);
                }
                _loc_2 = _loc_2 + (this.split1.height + 5);
                this.attributeTit.y = _loc_2;
                _loc_2 = _loc_2 + (this.attributeTit.height + 5);
                this.attributeTf.htmlText = this.getAttributeDesc(_loc_3.q_set_attribute);
                this.attributeTf.height = this.attributeTf.textHeight + 5;
                this.attributeTf.y = _loc_2;
                _loc_2 = _loc_2 + (this.attributeTf.height + 5);
                this.split2.y = _loc_2;
                _loc_2 = _loc_2 + (this.split2.height + 5);
                this.updateTime();
                if (this.lostTimeTf.text)
                {
                    this.lostTimeTf.y = _loc_2;
                    _loc_2 = _loc_2 + (this.lostTimeTf.height + 5);
                }
                else
                {
                    _loc_2 = this.split2.y;
                }
                this.split3.y = _loc_2;
                _loc_2 = _loc_2 + (this.split3.height + 5);
                this.descTf.htmlText = _loc_3.q_describe;
                this.descTf.height = this.descTf.textHeight + 5;
                this.descTf.y = _loc_2;
                _loc_2 = _loc_2 + (this.descTf.height + 5);
                this.tagItem.visible = !this._info.isModel;
                if (this.tagItem.visible)
                {
                    this.tagItem.y = _loc_2;
                    _loc_2 = _loc_2 + (this.tagItem.height + 20);
                }
                this.back.height = _loc_2;
            }
            else
            {
                this.removeTimer();
            }
            return;
        }// end function

        private function getAttributeDesc(param1:Array) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = "";
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = _loc_5[0];
                _loc_7 = _loc_5[1];
                if (_loc_4 != 0)
                {
                    _loc_2 = _loc_2 + "\n";
                }
                if (_loc_6 && _loc_7)
                {
                    _loc_2 = _loc_2 + (_loc_6 + "<font color=\'#00ff00\'>+" + _loc_7 + "</font>");
                }
                _loc_4++;
            }
            return _loc_2 ? (_loc_2) : (LanguageCfgObj.getInstance().getByIndex("10169"));
        }// end function

        private function updateTime(event:TimerManagerEvent = null) : void
        {
            var _loc_2:* = 0;
            if (this._info.isGot)
            {
                if (this._info.lostTime == -1)
                {
                    this.lostTimeTf.text = LanguageCfgObj.getInstance().getByIndex("10170");
                }
                else
                {
                    _loc_2 = this._info.leftTime;
                    if (_loc_2 > 0)
                    {
                        this.lostTimeTf.text = LanguageCfgObj.getInstance().getByIndex("11827") + ToolKit.second2CountDown(_loc_2);
                        if (this._timerId == null)
                        {
                            this._timerId = TimerManager.registerTimer(1, (_loc_2 + 1), this.updateTime);
                        }
                    }
                    else
                    {
                        this.lostTimeTf.text = "";
                        this.removeTimer();
                        this.layoutTail();
                    }
                }
            }
            else
            {
                this.lostTimeTf.text = "";
            }
            return;
        }// end function

        private function layoutTail() : void
        {
            var _loc_1:* = this.split2.y;
            this.split3.y = _loc_1;
            _loc_1 = _loc_1 + (this.split3.height + 5);
            this.descTf.y = _loc_1;
            _loc_1 = _loc_1 + (this.descTf.height + 5);
            this.tagItem.visible = !this._info.isModel;
            if (this.tagItem.visible)
            {
                this.tagItem.y = _loc_1;
                _loc_1 = _loc_1 + (this.tagItem.height + 20);
            }
            this.back.height = _loc_1;
            return;
        }// end function

        private function removeTimer() : void
        {
            TimerManager.killTimer(this._timerId);
            this._timerId = null;
            return;
        }// end function

        override public function remove() : void
        {
            this._titleImg.finalize();
            this.removeTimer();
            super.remove();
            return;
        }// end function

        private function initUI() : void
        {
            this.back = this._view["back"];
            this.vmcMc = this._view["vmcMc"];
            this._titleImg = new VMCView();
            this.vmcMc.addChild(this._titleImg);
            this.split1 = this._view["split1"];
            this.attributeTit = this._view["attributeTit"];
            this.attributeTf = this._view["attributeTf"];
            this.split2 = this._view["split2"];
            this.lostTimeTf = this._view["lostTimeTf"];
            this.split3 = this._view["split3"];
            this.descTf = this._view["descTf"];
            this.tagItem = this._view["tagItem"];
            return;
        }// end function

    }
}
