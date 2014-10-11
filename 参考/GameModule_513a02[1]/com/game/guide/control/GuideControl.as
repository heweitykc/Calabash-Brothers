package com.game.guide.control
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.game.guide.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class GuideControl extends Object
    {
        private var guideViewDic:Dictionary;
        private var guideDic:Dictionary;
        private var curTeamId:int;
        private var curIndex:int;
        private var arrowControl:GuideArrowControl;
        private static var _instance:GuideControl;

        public function GuideControl()
        {
            this.guideDic = new Dictionary();
            this.guideViewDic = new Dictionary();
            this.arrowControl = new GuideArrowControl();
            return;
        }// end function

        public function registerGuide(param1:DisplayObject, param2:IGuide, param3:String) : void
        {
            var _loc_4:* = param3.split("_");
            var _loc_5:* = int(_loc_4[0]);
            var _loc_6:* = int(_loc_4[1]);
            if (GuideConfigObj.getInstance().getGuideConfig(_loc_5) == 1)
            {
                return;
            }
            this.guideDic[param3] = param2;
            this.guideViewDic[param3] = param1;
            if (this.curTeamId != 0 && _loc_5 == this.curTeamId && (this.curIndex == _loc_6 || this.curTeamId == int(GuideConfigObj.getInstance().TASK_GUIDE_TEAM) && this.curIndex == 1))
            {
                this.showGuide(_loc_6);
            }
            return;
        }// end function

        public function unregisterGuide(param1:DisplayObject, param2:String) : void
        {
            if (this.guideDic && this.guideDic[param2])
            {
                this.guideDic[param2] = null;
                delete this.guideDic[param2];
                this.guideViewDic[param2] = null;
                delete this.guideViewDic[param2];
            }
            return;
        }// end function

        public function backGuide(param1:String, param2:int) : void
        {
            var _loc_6:* = null;
            var _loc_3:* = param1.split("_");
            var _loc_4:* = int(_loc_3[0]);
            var _loc_5:* = int(_loc_3[1]);
            if (_loc_4 == this.curTeamId && _loc_5 == this.curIndex)
            {
                _loc_6 = TaskCfgObj.getInstance().getGuideConfig(param1);
                if (_loc_6.q_back == "1")
                {
                    this.showGuide(param2);
                }
                else
                {
                    this.__guideItemClick(param1, true);
                }
            }
            return;
        }// end function

        public function beginGuide(param1:int) : void
        {
            this.curTeamId = param1;
            this.showGuide(1);
            return;
        }// end function

        private function showGuide(param1:int) : void
        {
            var guideId:String;
            var index:* = param1;
            this.curIndex = index;
            guideId = this.curTeamId + "_" + this.curIndex;
            if (this.guideViewDic[guideId] && IGuide(this.guideDic[guideId]).isGuideReady())
            {
                this.arrowControl.addArrow(this.guideViewDic[guideId], guideId);
                if (guideId != GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_2)
                {
                    this.guideViewDic[guideId].addEventListener(MouseEvent.CLICK, this._clickGuideItemHandler);
                    if (TaskGlobal.TEST_MODEL)
                    {
                        TweenLite.delayedCall(TaskGlobal.AUTO_GUIDE_CLICK, function () : void
            {
                guideViewDic[guideId].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                return;
            }// end function
            );
                    }
                }
                IGuide(this.guideDic[guideId]).guideAction(guideId);
            }
            else
            {
                this.arrowControl.hideArrow();
            }
            return;
        }// end function

        private function _clickGuideItemHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = this.curTeamId.toString();
            for (_loc_2 in this.guideViewDic)
            {
                
                if (event.currentTarget == _loc_5[_loc_2] && _loc_2.indexOf(_loc_3) != -1)
                {
                    this.__guideItemClick(_loc_2);
                }
            }
            return;
        }// end function

        public function guideItemClick(param1:String) : void
        {
            this.__guideItemClick(param1);
            return;
        }// end function

        private function __guideItemClick(param1:String, param2:Boolean = false) : void
        {
            var _loc_6:* = 0;
            var _loc_3:* = param1.split("_");
            var _loc_4:* = _loc_3[1];
            var _loc_5:* = _loc_3[0];
            if (this.guideViewDic[param1])
            {
                this.guideViewDic[param1].removeEventListener(MouseEvent.CLICK, this._clickGuideItemHandler);
            }
            if (TaskCfgObj.getInstance().getGuideConfig(_loc_5 + "_" + (_loc_4 + 1)) == null || param2)
            {
                _loc_6 = int(TaskCfgObj.getInstance().getGuideConfig(_loc_5 + "_" + _loc_4).q_next_id);
                if (_loc_6 != 0 && !param2)
                {
                    this.arrowControl.hideArrow();
                    this.beginGuide(_loc_6);
                }
                else
                {
                    this.arrowControl.removeArrow(this.guideViewDic[param1]);
                }
                if (this.guideDic[param1])
                {
                    IGuide(this.guideDic[param1]).guideEnd(param1);
                    this.finishTeamGuide(_loc_5);
                }
            }
            else if (param1 == this.curTeamId + "_" + this.curIndex)
            {
                (this.curIndex + 1);
                this.showGuide(this.curIndex);
            }
            return;
        }// end function

        public function hideArrow() : void
        {
            if (this.arrowControl)
            {
                this.arrowControl.hideArrow();
            }
            return;
        }// end function

        public function unHideArrow() : void
        {
            if (this.arrowControl)
            {
                this.arrowControl.unHideArrow();
            }
            return;
        }// end function

        public function finishTeamGuide(param1:int) : void
        {
            if (this.curTeamId == param1 && this.guideViewDic[this.curTeamId + "_" + this.curIndex])
            {
                this.guideViewDic[this.curTeamId + "_" + this.curIndex].removeEventListener(MouseEvent.CLICK, this._clickGuideItemHandler);
                this.arrowControl.removeArrow(this.guideViewDic[this.curTeamId + "_" + this.curIndex]);
            }
            var _loc_2:* = TaskCfgObj.getInstance().getGuideConfig(param1 + "_1");
            if (_loc_2 && _loc_2.q_multi == "0")
            {
                this.delTeamGuide(param1);
                GuideConfigObj.getInstance().saveConfigByTeam(param1, 1);
            }
            return;
        }// end function

        public function taskStopPath() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = TaskGlobal.task;
            if (_loc_1)
            {
                _loc_2 = TaskCfgObj.getInstance().getGuideConfigByTaskId(_loc_1.taskId, 0, GuideConfigObj.getInstance().FAST_TASK_BTN_GUIDE_ID);
                if (_loc_2)
                {
                    _loc_3 = _loc_2.q_id.split("_");
                    this.beginGuide(int(_loc_3[0]));
                }
            }
            return;
        }// end function

        private function delTeamGuide(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for (_loc_2 in this.guideViewDic)
            {
                
                _loc_3 = _loc_2.split("_");
                if (_loc_3[0] == param1.toString())
                {
                    _loc_5[_loc_2].removeEventListener(MouseEvent.CLICK, this._clickGuideItemHandler);
                    _loc_5[_loc_2] = null;
                    delete _loc_5[_loc_2];
                    this.guideDic[_loc_2] = null;
                    delete this.guideDic[_loc_2];
                }
            }
            return;
        }// end function

        private function __unlocatePoint(event:RoleEvent) : void
        {
            return;
        }// end function

        public static function getInstance() : GuideControl
        {
            var _loc_1:* = new GuideControl;
            _instance = new GuideControl;
            return _instance || _loc_1;
        }// end function

    }
}
