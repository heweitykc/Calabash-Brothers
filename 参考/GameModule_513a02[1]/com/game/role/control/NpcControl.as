package com.game.role.control
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.country.control.*;
    import com.game.country.view.*;
    import com.game.role.*;
    import com.game.role.model.*;
    import com.game.role.view.*;
    import com.game.store.control.*;
    import com.game.task.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import interfaces.role.*;

    public class NpcControl extends Object
    {
        private var clicked:Boolean;
        private var taskIconMap:Object;
        private static var _instance:NpcControl;

        public function NpcControl()
        {
            this.taskIconMap = new Object();
            return;
        }// end function

        public function init() : void
        {
            FrameworkGlobal.addMsgListen(TaskEvent.TASK_LIST_UPDATE, this.onTaskChange);
            return;
        }// end function

        public function set selectNpc(param1:INpc) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = NpcData.getInstance();
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.selectNpc && _loc_2.selectNpc != param1)
            {
                _loc_2.selectNpc.unSelect();
                if (param1)
                {
                    CountryControl.getInstance().stopGather();
                }
            }
            if (param1)
            {
                this.clicked = true;
                _loc_3 = _loc_2.taskMap[param1.info.cfgId];
                TaskGlobal.task_mode = _loc_3 != null;
                param1.select();
                _loc_2.selectNpc = param1;
                RoleManager.baseEvt.dispatchEvent(new GameEvent(GameEvent.CHANGE_SELECT_ROLE));
            }
            else
            {
                this.resetNpc();
            }
            return;
        }// end function

        private function resetNpc() : void
        {
            NpcData.getInstance().selectNpc = null;
            TaskGlobal.task_mode = false;
            this.checkAndClosePanel();
            return;
        }// end function

        public function checkAndClosePanel() : void
        {
            var _loc_1:* = NpcDialogControl.getInstance().npcDialogBox;
            if (_loc_1 && _loc_1.isOpen)
            {
                _loc_1.close();
            }
            var _loc_2:* = CountryControl.getInstance().countryTools;
            if (_loc_2 && _loc_2.isOpen)
            {
                _loc_2.close();
            }
            return;
        }// end function

        private function onTaskChange(event:TaskEvent) : void
        {
            this.resetIcon();
            return;
        }// end function

        public function resetIcon() : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_1:* = TaskModel.getInstance().mainTaskList;
            var _loc_2:* = _loc_1.length;
            _loc_3 = {};
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_6 = _loc_1[_loc_4];
                _loc_7 = _loc_6.conf;
                _loc_8 = _loc_7.q_endnpc;
                if (_loc_8 && !_loc_3[_loc_8])
                {
                    if (_loc_6.complete)
                    {
                        _loc_9 = uint(_loc_8);
                        _loc_10 = NpcList.getInstance().getNpcByCfgId(_loc_9) as NPC;
                        if (_loc_10)
                        {
                            if (this.taskIconMap[_loc_8])
                            {
                                _loc_11 = this.taskIconMap[_loc_8];
                                delete this.taskIconMap[_loc_8];
                            }
                            else
                            {
                                _loc_11 = ToolKit.getNew("npcTaskIconDone");
                            }
                            _loc_11.type = 1;
                            _loc_11.x = -8;
                            _loc_11.y = -_loc_10.high - 20;
                            _loc_11.play();
                            _loc_10.addChild(_loc_11);
                            _loc_3[_loc_8] = _loc_11;
                        }
                    }
                }
                _loc_4++;
            }
            for (_loc_5 in this.taskIconMap)
            {
                
                if (_loc_13[_loc_5])
                {
                    _loc_11 = _loc_13[_loc_5] as MovieClip;
                    if (_loc_11)
                    {
                        if (_loc_11.parent)
                        {
                            _loc_11.parent.removeChild(_loc_11);
                        }
                        _loc_11 = null;
                    }
                }
            }
            this.taskIconMap = _loc_3;
            return;
        }// end function

        public function setTaskIcon(param1:int, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = param1 + "";
            _loc_4 = NpcList.getInstance().getNpcByCfgId(param1) as NPC;
            if (_loc_4)
            {
                if (param2)
                {
                    if (this.taskIconMap[_loc_3])
                    {
                        _loc_5 = this.taskIconMap[_loc_3];
                        if (_loc_5.parent)
                        {
                            _loc_5.parent.removeChild(_loc_5);
                            _loc_5.stop();
                            _loc_5 = null;
                        }
                    }
                    _loc_5 = ToolKit.getNew("npcTaskIconDone");
                    this.taskIconMap[_loc_3] = _loc_5;
                    _loc_5.type = 1;
                    _loc_5.x = -8;
                    _loc_5.y = -_loc_4.high - 20;
                    _loc_5.play();
                    _loc_4.addChild(_loc_5);
                }
                else if (this.taskIconMap[_loc_3])
                {
                    _loc_5 = this.taskIconMap[_loc_3];
                    if (_loc_5.parent)
                    {
                        _loc_5.parent.removeChild(_loc_5);
                        _loc_5 = null;
                    }
                    delete this.taskIconMap[_loc_3];
                }
            }
            return;
        }// end function

        public function openStorage() : void
        {
            StoreControl.getInstance().openStorageFree();
            return;
        }// end function

        public function openStore() : void
        {
            StoreControl.getInstance().openStorageFree();
            return;
        }// end function

        public function arriveHanlder() : void
        {
            var _loc_1:* = NpcData.getInstance().selectNpc;
            if (_loc_1 == null)
            {
                return;
            }
            var _loc_2:* = NpcCfgObj.getInstance().getNpcByID(_loc_1.info.cfgId + "");
            if (_loc_1 && _loc_1.info && (_loc_2._type == 1 || _loc_1.info.cfgId == 105001))
            {
                RoleManager.npcProtocal.reqNpcServices(_loc_1.info.personId);
                return;
            }
            if (this.clicked)
            {
                this.clicked = false;
                if (NpcDialogControl.getInstance().npcDialogBox.isOpen)
                {
                    NpcDialogControl.getInstance().npcDialogBox.close();
                }
                else
                {
                    NpcDialogControl.getInstance().setNpc(_loc_1);
                    if (_loc_1.info.cfgId == Params.COUNTRY_NPC)
                    {
                        CountryControl.getInstance().openCountryTools();
                    }
                    else
                    {
                        NpcDialogControl.getInstance().npcDialogBox.open();
                    }
                }
            }
            return;
        }// end function

        public function npcFindPath(param1:int) : void
        {
            var _loc_2:* = NpcCfgObj.getInstance().getNpcByID(param1.toString());
            if (_loc_2)
            {
                TaskGlobal.manager.taskFindPath(_loc_2._x, _loc_2._y, _loc_2._map, true);
                NpcData.getInstance().arriveSelectNpc = param1;
            }
            return;
        }// end function

        public static function getInstance() : NpcControl
        {
            if (_instance == null)
            {
                _instance = new NpcControl;
            }
            return _instance;
        }// end function

    }
}
