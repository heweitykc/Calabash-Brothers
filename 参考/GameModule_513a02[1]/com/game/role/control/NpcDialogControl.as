package com.game.role.control
{
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.equipstreng.control.*;
    import com.game.role.model.*;
    import com.game.role.view.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.game.xscb.control.*;
    import flash.events.*;
    import interfaces.role.*;

    public class NpcDialogControl extends Object
    {
        private var _npcDialogBox:NpcDialogBox;
        private var _npc:INpc;
        private static var _instance:NpcDialogControl;

        public function NpcDialogControl()
        {
            return;
        }// end function

        public function get npcDialogBox() : NpcDialogBox
        {
            if (!this._npcDialogBox)
            {
                this._npcDialogBox = new NpcDialogBox();
                Global.popManager.addPop(this._npcDialogBox);
            }
            return this._npcDialogBox;
        }// end function

        public function openNpcDialogBox() : void
        {
            this._npcDialogBox.openOrClose();
            return;
        }// end function

        public function setNpc(param1:INpc) : void
        {
            var _loc_4:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (param1 == null)
            {
                return;
            }
            this._npc = param1;
            var _loc_2:* = {title:LanguageCfgObj.getInstance().getByIndex("12179"), talker:"Npc", content:"", label1:"", label2:"", label3:"", label4:""};
            var _loc_3:* = [];
            _loc_4 = param1.info.cfgId + "";
            var _loc_5:* = NpcCfgObj.getInstance().getNpcByID(_loc_4);
            _loc_2.title = _loc_5._npcName;
            _loc_2.talker = _loc_5._npcName;
            _loc_2.content = _loc_5._dialog ? (_loc_5._dialog) : (LanguageCfgObj.getInstance().getByIndex("11123"));
            var _loc_6:* = _loc_5._function;
            var _loc_7:* = _loc_6.split(";");
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7.length)
            {
                
                _loc_9 = _loc_7[_loc_8].toString().split("|");
                _loc_10 = int(_loc_9[0]);
                switch(_loc_10)
                {
                    case 1:
                    {
                        _loc_11 = NpcData.getInstance().taskMap[_loc_4] as TaskMsgVO;
                        if (_loc_11)
                        {
                            TaskGlobal.task = _loc_11;
                            _loc_12 = _loc_11.conf.q_name + (_loc_11.complete ? ("(" + LanguageCfgObj.getInstance().getByIndex("12180") + ")") : ("(" + LanguageCfgObj.getInstance().getByIndex("12181") + ")"));
                            _loc_3.push("<u><a href =\'event:1\'><font color=\'#dac53b\'>" + _loc_12 + "</font></a></u>");
                        }
                        break;
                    }
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    {
                        if (_loc_9[1])
                        {
                            _loc_3.push("<u><a href =\'event:" + _loc_9[0] + "\'><font color=\'#1bc830\'>" + _loc_9[1] + "</font></a></u>");
                        }
                        break;
                    }
                    case 20:
                    {
                        this.setScript(_loc_5);
                        return;
                    }
                    default:
                    {
                        if (_loc_9[1])
                        {
                            _loc_3.push("<u><a href =\'event:" + _loc_9[0] + "\'><font color=\'#1bc830\'>" + _loc_9[1] + "</font></a></u>");
                        }
                        break;
                        break;
                    }
                }
                _loc_8++;
            }
            _loc_3.push(LanguageCfgObj.getInstance().getByIndex("11124"));
            _loc_8 = 0;
            while (_loc_8 < _loc_3.length)
            {
                
                _loc_2["label" + (_loc_8 + 1)] = _loc_3[_loc_8];
                _loc_8++;
            }
            this._npcDialogBox.data = _loc_2;
            return;
        }// end function

        public function closeNpcDialog() : void
        {
            if (this._npcDialogBox && this._npcDialogBox.isOpen)
            {
                this._npcDialogBox.close();
            }
            return;
        }// end function

        public function setScript(param1:NpcCfg) : void
        {
            var _loc_2:* = null;
            switch(param1._npcModelId)
            {
                case 401001:
                case 402001:
                case 403001:
                case 404001:
                case 405001:
                case 406001:
                case 407001:
                case 408001:
                case 408002:
                case 408003:
                case 408004:
                case 408005:
                case 408006:
                {
                    _loc_2 = ScarletHoldControl.getInstance().dealNPC(param1._npcModelId);
                    this._npcDialogBox.data = _loc_2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function parseLink(event:TextEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = int(event.text);
            _loc_3 = this._npc.info.cfgId + "";
            _loc_4 = NpcCfgObj.getInstance().getNpcByID(_loc_3);
            switch(_loc_2)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    _loc_5 = NpcData.getInstance().taskMap[_loc_3] as TaskMsgVO;
                    if (_loc_5)
                    {
                        TaskGlobal.manager.showNpcTalkPanel(_loc_5);
                    }
                    break;
                }
                case 2:
                {
                    _loc_6 = _loc_4._shop;
                    if (_loc_6 != "")
                    {
                        NpcShopControl.getInstance().showNpcShopByCfg(_loc_4);
                    }
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox();
                    break;
                }
                case 5:
                {
                    NpcControl.getInstance().openStorage();
                    break;
                }
                case 6:
                {
                    break;
                }
                case 20:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function isNpcDialogOpen() : Boolean
        {
            return this._npcDialogBox && this._npcDialogBox.isOpen;
        }// end function

        public static function getInstance() : NpcDialogControl
        {
            if (_instance == null)
            {
                _instance = new NpcDialogControl;
            }
            return _instance;
        }// end function

    }
}
