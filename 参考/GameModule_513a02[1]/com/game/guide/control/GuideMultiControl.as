package com.game.guide.control
{
    import com.cfg.obj.*;
    import com.f1.manager.keyboard.*;
    import com.game.guide.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class GuideMultiControl extends Object
    {
        private var guideViewDic:Dictionary;
        private var guideDic:Dictionary;
        private var guideStateDic:Dictionary;
        private var arrowControlDic:Dictionary;
        private static var _instance:GuideMultiControl;

        public function GuideMultiControl()
        {
            this.guideDic = new Dictionary();
            this.guideViewDic = new Dictionary();
            this.guideStateDic = new Dictionary();
            this.arrowControlDic = new Dictionary();
            return;
        }// end function

        public function registerGuide(param1:DisplayObject, param2:IGuide, param3:String) : void
        {
            var _loc_4:* = param3.split("_");
            var _loc_5:* = int(_loc_4[0]);
            var _loc_6:* = int(_loc_4[1]);
            this.guideDic[param3] = param2;
            this.guideViewDic[param3] = param1;
            if (this.guideStateDic[_loc_5] && this.guideStateDic[_loc_5] != 0 && this.guideStateDic[_loc_5] == _loc_6)
            {
                this.showGuide(param3);
            }
            return;
        }// end function

        public function unregisterGuide(param1:DisplayObject, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (this.guideDic && this.guideDic[param2])
            {
                _loc_3 = param2.split("_");
                _loc_4 = _loc_3[0];
                this.guideDic[param2] = null;
                delete this.guideDic[param2];
                this.guideViewDic[param2] = null;
                delete this.guideViewDic[param2];
                if (this.arrowControlDic[_loc_4])
                {
                    this.arrowControlDic[_loc_4].dispose();
                    this.arrowControlDic[_loc_4] = null;
                    delete this.arrowControlDic[_loc_4];
                }
            }
            return;
        }// end function

        public function backGuide(param1:String, param2:int) : void
        {
            var _loc_3:* = param1.split("_");
            var _loc_4:* = int(_loc_3[0]);
            var _loc_5:* = int(_loc_3[1]);
            var _loc_6:* = TaskCfgObj.getInstance().getGuideConfig(param1);
            if (this.guideStateDic[_loc_4] && this.guideStateDic[_loc_4] == _loc_5)
            {
                if (_loc_6.q_back == "1")
                {
                    this.showGuide(_loc_4 + "_" + param2);
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
            this.showGuide(param1 + "_1");
            return;
        }// end function

        private function showGuide(param1:String) : void
        {
            var obj:Object;
            var guideId:* = param1;
            var arr:* = guideId.split("_");
            var team:* = int(arr[0]);
            var index:* = int(arr[1]);
            if (!this.arrowControlDic[team] && index != 1)
            {
                return;
            }
            this.guideStateDic[team] = index;
            if (!this.arrowControlDic[team])
            {
                this.arrowControlDic[team] = new GuideArrowControl();
            }
            var arrowControl:* = this.arrowControlDic[team];
            if (this.guideViewDic[guideId] && IGuide(this.guideDic[guideId]).isGuideReady())
            {
                arrowControl.unHideArrow();
                arrowControl.addArrow(this.guideViewDic[guideId], guideId);
                if (this.guideViewDic[guideId] is TextField)
                {
                    this.guideViewDic[guideId].addEventListener(TextEvent.LINK, this._clickGuideTextHandler);
                }
                else
                {
                    this.guideViewDic[guideId].addEventListener(MouseEvent.CLICK, this._clickGuideItemHandler);
                }
                if (TaskGlobal.TEST_MODEL)
                {
                    TweenLite.delayedCall(TaskGlobal.AUTO_GUIDE_CLICK, function () : void
            {
                guideViewDic[guideId].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                return;
            }// end function
            );
                }
                IGuide(this.guideDic[guideId]).guideAction(guideId);
                obj = TaskCfgObj.getInstance().getGuideConfig(guideId);
                if (obj.q_hotkey != "")
                {
                    KeyboardManager.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
                }
            }
            else
            {
                arrowControl.hideArrow();
            }
            return;
        }// end function

        private function __keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = event.keyCode;
            var _loc_5:* = 97 + (event.keyCode - 65);
            for (_loc_2 in this.guideViewDic)
            {
                
                _loc_3 = TaskCfgObj.getInstance().getGuideConfig(_loc_2);
                if (_loc_3.q_hotkey && _loc_3.q_hotkey.charCodeAt(0) == _loc_5)
                {
                    KeyboardManager.removeEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
                    this.__guideItemClick(_loc_2);
                }
            }
            return;
        }// end function

        private function _clickGuideItemHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            for (_loc_2 in this.guideViewDic)
            {
                
                _loc_3 = _loc_2.split("_");
                _loc_4 = int(_loc_3[0]);
                _loc_5 = int(_loc_3[1]);
                if (_loc_8[_loc_2] == event.currentTarget && this.arrowControlDic[_loc_4])
                {
                    _loc_6 = true;
                    break;
                }
            }
            if (_loc_6)
            {
                this.__guideItemClick(_loc_2);
            }
            return;
        }// end function

        private function _clickGuideTextHandler(event:TextEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            for (_loc_2 in this.guideViewDic)
            {
                
                _loc_3 = _loc_2.split("_");
                _loc_4 = int(_loc_3[0]);
                _loc_5 = int(_loc_3[1]);
                if (_loc_8[_loc_2] == event.currentTarget && this.arrowControlDic[_loc_4])
                {
                    _loc_6 = true;
                    break;
                }
            }
            if (_loc_6)
            {
                this.__guideItemClick(_loc_2);
            }
            return;
        }// end function

        private function __guideItemClick(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this.guideViewDic[param1])
            {
                _loc_3 = param1.split("_");
                _loc_4 = int(_loc_3[0]);
                _loc_5 = int(_loc_3[1]);
                if (this.guideViewDic[param1] is TextField)
                {
                    this.guideViewDic[param1].removeEventListener(TextEvent.LINK, this._clickGuideTextHandler);
                }
                else
                {
                    this.guideViewDic[param1].removeEventListener(MouseEvent.CLICK, this._clickGuideItemHandler);
                }
                if (TaskCfgObj.getInstance().getGuideConfig(_loc_4 + "_" + (_loc_5 + 1)) == null)
                {
                    _loc_6 = this.arrowControlDic[_loc_4];
                    if (_loc_6)
                    {
                        _loc_6.removeArrow(this.guideViewDic[param1]);
                    }
                    if (this.guideDic[param1])
                    {
                        IGuide(this.guideDic[param1]).guideEnd(param1);
                    }
                    this.finishTeamGuide(_loc_4);
                }
                else
                {
                    this.showGuide(_loc_4 + "_" + (_loc_5 + 1));
                }
            }
            return;
        }// end function

        public function finishTeamGuide(param1:int) : void
        {
            var _loc_2:* = this.arrowControlDic[param1];
            if (_loc_2)
            {
                _loc_2.dispose();
                _loc_2 = null;
            }
            this.arrowControlDic[param1] = null;
            delete this.arrowControlDic[param1];
            this.guideStateDic[param1] = null;
            delete this.guideStateDic[param1];
            return;
        }// end function

        public function hideGuide(param1:String) : void
        {
            var _loc_2:* = param1.split("_");
            var _loc_3:* = int(_loc_2[0]);
            var _loc_4:* = int(_loc_2[1]);
            var _loc_5:* = this.arrowControlDic[_loc_3];
            if (this.arrowControlDic[_loc_3])
            {
                _loc_5.hideArrow();
            }
            return;
        }// end function

        public function unHideGuide(param1:String) : void
        {
            var _loc_2:* = param1.split("_");
            var _loc_3:* = int(_loc_2[0]);
            var _loc_4:* = int(_loc_2[1]);
            var _loc_5:* = this.arrowControlDic[_loc_3];
            if (this.arrowControlDic[_loc_3])
            {
                _loc_5.unHideArrow();
            }
            return;
        }// end function

        public function onDeleteCompleteTask(param1:int) : void
        {
            if (TaskCfgObj.getInstance().getGuideConfigByTaskId(param1, 0, GuideConfigObj.getInstance().COMPOSE_XS_DRESS_GUIDE_ID_2))
            {
                this.beginGuide(int(GuideConfigObj.getInstance().COMPOSE_XS_DRESS_TEAM));
            }
            if (TaskCfgObj.getInstance().getGuideConfigByTaskId(param1, 0, GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_1))
            {
                this.beginGuide(int(GuideConfigObj.getInstance().COMPOSE_TICKET_TEAM));
            }
            return;
        }// end function

        public static function getInstance() : GuideMultiControl
        {
            var _loc_1:* = new GuideMultiControl;
            _instance = new GuideMultiControl;
            return _instance || _loc_1;
        }// end function

    }
}
