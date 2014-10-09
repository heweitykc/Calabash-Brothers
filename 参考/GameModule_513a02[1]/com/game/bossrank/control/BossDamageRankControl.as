package com.game.bossrank.control
{
    import __AS3__.vec.*;
    import com.f1.utils.*;
    import com.game.bossrank.model.*;
    import com.game.bossrank.protocol.*;
    import com.game.bossrank.view.*;
    import com.game.monster.message.*;
    import com.game.role.*;
    import com.game.task.view.*;
    import com.game.utils.*;
    import com.model.*;
    import interfaces.role.*;

    public class BossDamageRankControl extends Object
    {
        private var lastTeamInfo:Vector.<TeamMemberDamage>;
        private var _bossDamageRankView:BossDamageRankView;
        private var _protocol:BossDamageRankProtocol;
        private static var _instance:BossDamageRankControl;

        public function BossDamageRankControl()
        {
            this._protocol = new BossDamageRankProtocol();
            return;
        }// end function

        public function get bossDamageRankView() : BossDamageRankView
        {
            return this._bossDamageRankView;
        }// end function

        public function openBossDamageRankView(param1:int = 1) : void
        {
            if (!this._bossDamageRankView)
            {
                this._bossDamageRankView = new BossDamageRankView();
            }
            this._bossDamageRankView.open(param1);
            return;
        }// end function

        public function closeBossDamageRankView() : void
        {
            if (this._bossDamageRankView)
            {
                this._bossDamageRankView.close();
            }
            return;
        }// end function

        public function resResponseBossDamageHandler(param1:ResResponseBossDamageMessage) : void
        {
            var _loc_2:* = FastTaskPanel.getInstance();
            if (!_loc_2.btn_down)
            {
                return;
            }
            var _loc_3:* = param1.monsterId;
            var _loc_4:* = BossDamageData.getInstance().monsterId;
            if (!BossDamageData.getInstance().monsterId || _loc_4.equal(_loc_3))
            {
                BossDamageData.getInstance().damageInfos = param1.damageInfos;
                BossDamageData.getInstance().monsterId = param1.monsterId;
                return;
            }
            var _loc_5:* = RoleList.getInstance().getRole(_loc_3);
            var _loc_6:* = RoleList.getInstance().getRole(_loc_4);
            var _loc_7:* = RoleList.getInstance().player;
            var _loc_8:* = -1;
            if (_loc_5)
            {
                _loc_8 = ToolKit.distance(_loc_7._x, _loc_7._y, _loc_5._x, _loc_5._y);
            }
            var _loc_9:* = -1;
            if (_loc_6)
            {
                _loc_9 = ToolKit.distance(_loc_7._x, _loc_7._y, _loc_6._x, _loc_6._y);
            }
            if (_loc_8 < _loc_9 && _loc_8 != -1 || _loc_9 == -1)
            {
                BossDamageData.getInstance().damageInfos = param1.damageInfos;
                BossDamageData.getInstance().monsterId = param1.monsterId;
            }
            return;
        }// end function

        public function showBossDamageIcon(param1:Vector.<CaptainDamageInfo>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param1 && param1.length)
            {
                this.clearDropIcon();
                _loc_2 = param1[0].teamInfo;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_4 = RoleList.getInstance().getRole(_loc_2[_loc_3].personid);
                    if (_loc_4)
                    {
                        (_loc_4 as Role).addBossDamageIcon();
                    }
                    _loc_3++;
                }
                this.lastTeamInfo = _loc_2;
            }
            return;
        }// end function

        public function clearDropIcon() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this.lastTeamInfo)
            {
                _loc_1 = 0;
                while (_loc_1 < this.lastTeamInfo.length)
                {
                    
                    _loc_2 = RoleList.getInstance().getRole(this.lastTeamInfo[_loc_1].personid);
                    if (_loc_2)
                    {
                        (_loc_2 as Role).removeBossDamageIcon();
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        public function setDropIconNull() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this.lastTeamInfo)
            {
                _loc_1 = 0;
                while (_loc_1 < this.lastTeamInfo.length)
                {
                    
                    _loc_2 = RoleList.getInstance().getRole(this.lastTeamInfo[_loc_1].personid);
                    if (_loc_2)
                    {
                        (_loc_2 as Role).setBossDamageIconNull();
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        public static function getInstance() : BossDamageRankControl
        {
            if (_instance == null)
            {
                _instance = new BossDamageRankControl;
            }
            return _instance;
        }// end function

    }
}
