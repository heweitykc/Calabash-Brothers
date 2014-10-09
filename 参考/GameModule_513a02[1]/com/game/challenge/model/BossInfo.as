package com.game.challenge.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.game.challenge.bean.*;
    import com.game.challenge.event.*;
    import com.game.challenge.message.*;
    import com.game.utils.*;

    public class BossInfo extends BaseEventDispatcher
    {
        private const TOP_LEN:int = 33;
        private const LOGLEN:int = 30;
        private const SIGNLE_LOGLEN:int = 5;
        private var monsterLen:int;
        private var _config:Array;
        private var _bossIds:Array;
        private var _bossLogs:Array;
        private var _dropLog:Array;
        public var serverTime:Number;

        public function BossInfo()
        {
            this._config = QMonsterBossQcfgObj.getInstance().getMonsterBossListPage();
            this._bossIds = new Array();
            this.monsterLen = this._config.length;
            var _loc_1:* = 0;
            while (_loc_1 < this.monsterLen)
            {
                
                this._bossIds.push((this._config[_loc_1] as QMonsterBossQcfg).q_monsterid);
                _loc_1++;
            }
            this._bossLogs = new Array(this.monsterLen);
            this._dropLog = new Array();
            return;
        }// end function

        private function reset() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.monsterLen)
            {
                
                this._bossLogs[_loc_1] = null;
                _loc_1++;
            }
            return;
        }// end function

        public function setInfo(param1:ResBossEventMessage) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1.type == 2)
            {
                this._dropLog = new Array();
                _loc_2 = param1.events.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    this._dropLog.push(param1.events[_loc_4]);
                    _loc_4++;
                }
                _loc_2 = param1.pandoraEvents.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    this._dropLog.push(param1.pandoraEvents[_loc_4]);
                    _loc_4++;
                }
                this._dropLog.sort(this.sortOnBossDrop);
                dispatchEvt(new BossGuideEvent(BossGuideEvent.UPDATELOG));
            }
            else if (param1.type == 3)
            {
                if (param1.events.length > 0)
                {
                    this.push(this._dropLog, param1.events[0]);
                }
                else if (param1.pandoraEvents.length > 0)
                {
                    this.push(this._dropLog, param1.pandoraEvents[0]);
                }
                if (this._dropLog.length > this.LOGLEN)
                {
                    this._dropLog.pop();
                }
                dispatchEvt(new BossGuideEvent(BossGuideEvent.UPDATELOG));
            }
            return;
        }// end function

        private function push(param1:Array, param2) : Boolean
        {
            var _loc_4:* = undefined;
            if (param1 == null)
            {
                return false;
            }
            var _loc_3:* = param1.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = param1[_loc_5];
                if (((_loc_4.type | param2.type) & 1) == 0)
                {
                    if ((_loc_4.time as long).toNumber() > (param2.time as long).toNumber())
                    {
                        ;
                    }
                    else if (_loc_5 >= 4)
                    {
                        param1[_loc_5] = param2;
                    }
                    else
                    {
                        param1.splice(_loc_5, 0, param2);
                        if (_loc_3 > this.TOP_LEN && param1[(this.TOP_LEN - 1)] && (param1[(this.TOP_LEN - 1)].type & 1) == 0)
                        {
                            param1.splice((this.TOP_LEN - 1), 1);
                        }
                        return true;
                    }
                }
                else if (1 & _loc_4.type & param2.type)
                {
                    if ((_loc_4.time as long).toNumber() > (param2.time as long).toNumber())
                    {
                        ;
                    }
                    else
                    {
                        param1.splice(_loc_5, 0, param2);
                        return true;
                    }
                }
                else
                {
                    if ((1 & param2.type) == 0)
                    {
                        param1.splice(0, 0, param2);
                        return true;
                    }
                    ;
                }
                _loc_5++;
            }
            if (_loc_5 >= _loc_3)
            {
                param1.push(param2);
                return true;
            }
            return false;
        }// end function

        private function sortOnBossDrop(param1, param2) : int
        {
            if (1 & param1.type & param2.type)
            {
                return (param1.time as long).toNumber() < (param2.time as long).toNumber() ? (1) : (-1);
            }
            else
            {
                if (((param1.type | param2.type) & 1) == 0)
                {
                    return (param1.time as long).toNumber() < (param2.time as long).toNumber() ? (1) : (-1);
                }
            }
            return 1;
            return -1;
        }// end function

        public function setBossHitInfo(param1:ResBossKillMessage) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            this.serverTime = param1.serverTime.toNumber();
            this.reset();
            var _loc_5:* = param1.bossInfos;
            _loc_2 = _loc_5.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_6 = this.filter(_loc_5[_loc_4]);
                if (_loc_6 != -1)
                {
                    this._bossLogs[_loc_6] = _loc_5[_loc_4];
                }
                _loc_4++;
            }
            dispatchEvt(new BossGuideEvent(BossGuideEvent.UPDATEBOSS));
            return;
        }// end function

        private function filter(param1:BossKillInfo) : int
        {
            var _loc_2:* = this._bossIds.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1.bossId == this._bossIds[_loc_3])
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function get config() : Array
        {
            return this._config;
        }// end function

        public function get bossIds() : Array
        {
            return this._bossIds;
        }// end function

        public function get bossLogs() : Array
        {
            return this._bossLogs;
        }// end function

        public function get dropLog() : Array
        {
            return this._dropLog;
        }// end function

    }
}
