package com.game.prenotice.control
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.game.guide.model.*;
    import com.game.prenotice.model.*;
    import com.game.prenotice.view.*;
    import com.game.task.events.*;
    import com.model.*;

    public class PrenoticeControl extends Object
    {
        private var _view:PrenoticeView;
        private var curCfg:Object;
        private var _prenoticeVisible:Boolean = true;
        private static var instance:PrenoticeControl;

        public function PrenoticeControl()
        {
            this.addLis();
            var _loc_1:* = PrenoticeCfgObj.getInstance().getCfgByIndex(this.getCurrent());
            if (_loc_1)
            {
                this.showByCfg(_loc_1, 0, true);
            }
            return;
        }// end function

        private function addLis() : void
        {
            FrameworkGlobal.addMsgListen(TaskEvent.DELETE_COMPLETE_TASK, this._completeTask);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this._userLevelUpdate);
            return;
        }// end function

        private function _completeTask(event:TaskEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = PrenoticeCfgObj.getInstance().getCfgByTaskId(int(event.data));
            if (_loc_2)
            {
                _loc_3 = this.getCurNext();
                _loc_4 = GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM));
                _loc_5 = _loc_4.toString(2);
                _loc_5 = this.saveStr(_loc_5, int(_loc_2.q_id), 1);
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM), parseInt(_loc_5, 2));
                if (_loc_3 == int(_loc_2.q_id))
                {
                    this.showByCfg(PrenoticeCfgObj.getInstance().getCfgByIndex(this.getCurrent()), 0);
                }
            }
            return;
        }// end function

        private function _userLevelUpdate(event:RoleEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = PrenoticeCfgObj.getInstance().getCfgByLv(UserObj.getInstance().playerInfo.level);
            var _loc_4:* = false;
            var _loc_5:* = this.getCurNext();
            var _loc_6:* = GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM));
            var _loc_7:* = _loc_6.toString(2);
            if (_loc_2.length)
            {
                _loc_7 = this.saveStr(_loc_7, 0, 1);
            }
            var _loc_8:* = 0;
            while (_loc_8 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_8];
                if (_loc_3)
                {
                    _loc_7 = this.saveStr(_loc_7, int(_loc_3.q_id), 1);
                    if (_loc_5 == int(_loc_3.q_id))
                    {
                        _loc_4 = true;
                    }
                }
                _loc_8++;
            }
            GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM), parseInt(_loc_7, 2));
            if (_loc_4)
            {
                this.showByCfg(PrenoticeCfgObj.getInstance().getCfgByIndex(this.getCurrent()), 0);
            }
            return;
        }// end function

        private function showByCfg(param1:Object, param2:int, param3:Boolean = false) : void
        {
            if (param1 == null || param1.q_id == 0)
            {
                this.close();
                return;
            }
            if (!this._view)
            {
                this._view = new PrenoticeView();
                this._view.visible = this._prenoticeVisible;
                this._view.move(3, 140);
            }
            var _loc_4:* = this.getCurNext();
            this.saveAllGuideConfig(param2, 1);
            if (!param3 && _loc_4 == 0 && int(param1.q_id) != 1)
            {
                this.close();
                return;
            }
            this.curCfg = param1;
            this._view.showByCfg(param1);
            Global.mainUIManager.addUI(this._view, null, 0, true);
            return;
        }// end function

        private function saveAllGuideConfig(param1:int, param2:int) : void
        {
            var _loc_3:* = GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM));
            var _loc_4:* = _loc_3.toString(2);
            _loc_4 = this.saveStr(_loc_4, param1, param2);
            GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM), parseInt(_loc_4, 2));
            return;
        }// end function

        private function saveStr(param1:String, param2:int, param3:int) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_4:* = int(param2);
            if (param1.length >= _loc_4)
            {
                _loc_5 = param1.substring((_loc_4 + 1));
                _loc_6 = param1.substring(0, _loc_4);
                param1 = _loc_6 + param3.toString() + _loc_5;
            }
            else
            {
                _loc_7 = "";
                _loc_8 = 0;
                while (_loc_8 < _loc_4 - param1.length)
                {
                    
                    _loc_7 = _loc_7 + "0";
                    _loc_8++;
                }
                param1 = param1 + _loc_7 + param3.toString();
            }
            return param1;
        }// end function

        private function getCurNext() : int
        {
            var _loc_1:* = this.getCurrent();
            var _loc_2:* = GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM));
            var _loc_3:* = _loc_2.toString(2);
            if (_loc_1 > (_loc_3.length - 1))
            {
                return _loc_1;
            }
            while (_loc_1 < _loc_3.length)
            {
                
                if (_loc_3.charAt(_loc_1) == "0")
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            if (PrenoticeCfgObj.getInstance().getCfgByIndex(_loc_1) != null)
            {
                return int(PrenoticeCfgObj.getInstance().getCfgByIndex(_loc_1).q_goto);
            }
            return 0;
        }// end function

        private function getCurrent() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ACTIVE_GUIDE_ALL_CONFIG_TEAM));
            var _loc_3:* = _loc_2.toString(2);
            if (_loc_3 == "0")
            {
                return 0;
            }
            if (_loc_1 > (_loc_3.length - 1))
            {
                return _loc_1;
            }
            while (_loc_1 < _loc_3.length)
            {
                
                if (_loc_3.charAt(_loc_1) != "1")
                {
                    if (PrenoticeCfgObj.getInstance().getCfgByGoto(_loc_1) != null)
                    {
                        return int(PrenoticeCfgObj.getInstance().getCfgByGoto(_loc_1).q_id);
                    }
                    return 0;
                }
                _loc_1++;
            }
            if (PrenoticeCfgObj.getInstance().getCfgByIndex(_loc_1) != null)
            {
                return _loc_1;
            }
            return 0;
        }// end function

        private function close() : void
        {
            if (this._view)
            {
                Global.mainUIManager.removeUI(this._view);
                this._view.close();
            }
            return;
        }// end function

        public function setPrenoticeVisible(param1:Boolean) : void
        {
            this._prenoticeVisible = param1;
            if (this._view)
            {
                this._view.visible = this._prenoticeVisible;
            }
            return;
        }// end function

        public static function getInstance() : PrenoticeControl
        {
            if (instance == null)
            {
                instance = new PrenoticeControl;
            }
            return instance;
        }// end function

    }
}
