package com.game.bossrank.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.game.bossrank.control.*;
    import com.game.bossrank.events.*;
    import com.game.monster.bean.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;

    public class BossDamageData extends BaseEventDispatcher
    {
        private var _monsterId:long;
        private var _damageInfos:Vector.<CaptainDamageInfo>;
        private var isFirst:Boolean = false;
        private var hasOpen:Boolean = false;
        private static var _instance:BossDamageData;

        public function BossDamageData()
        {
            this._damageInfos = new Vector.<CaptainDamageInfo>;
            return;
        }// end function

        public function get damageInfos() : Vector.<CaptainDamageInfo>
        {
            return this._damageInfos;
        }// end function

        public function set damageInfos(param1:Vector.<CaptainDamageInfo>) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._damageInfos = param1;
            this._damageInfos.sort(this.compare);
            BossDamageRankControl.getInstance().showBossDamageIcon(this._damageInfos);
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = param1[_loc_2];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.teamInfo.length)
                {
                    
                    if (UserObj.getInstance().playerInfo && UserObj.getInstance().playerInfo.personId.equal(_loc_3.teamInfo[_loc_4].personid))
                    {
                        if (!this.hasOpen)
                        {
                            if (ZonesControl.getInstance().inBossHome())
                            {
                                BossDamageRankControl.getInstance().openBossDamageRankView(3);
                            }
                            else
                            {
                                BossDamageRankControl.getInstance().openBossDamageRankView(2);
                            }
                            this.hasOpen = true;
                        }
                        return;
                    }
                    _loc_4++;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function compare(param1:CaptainDamageInfo, param2:CaptainDamageInfo) : int
        {
            if (param1.damage < param2.damage)
            {
                return 1;
            }
            if (param1.damage > param2.damage)
            {
                return -1;
            }
            return 0;
        }// end function

        public function get monsterId() : long
        {
            return this._monsterId;
        }// end function

        public function set monsterId(param1:long) : void
        {
            this._monsterId = param1;
            dispatchEvt(new BossDamageEvent(BossDamageEvent.BOSS_DAMAGE_DATA_CHANGE));
            if (!this.isFirst)
            {
                this.isFirst = true;
                if (ZonesControl.getInstance().inBossHome())
                {
                    BossDamageRankControl.getInstance().openBossDamageRankView(3);
                }
                else if (this.hasOpen)
                {
                    BossDamageRankControl.getInstance().openBossDamageRankView(2);
                }
                else
                {
                    BossDamageRankControl.getInstance().openBossDamageRankView();
                }
            }
            TweenLite.killDelayedCallsTo(this.reset);
            TweenLite.delayedCall(2, this.reset);
            return;
        }// end function

        private function reset() : void
        {
            this.isFirst = false;
            this.hasOpen = false;
            BossDamageRankControl.getInstance().closeBossDamageRankView();
            BossDamageRankControl.getInstance().setDropIconNull();
            return;
        }// end function

        public static function getInstance() : BossDamageData
        {
            if (_instance == null)
            {
                _instance = new BossDamageData;
            }
            return _instance;
        }// end function

    }
}
