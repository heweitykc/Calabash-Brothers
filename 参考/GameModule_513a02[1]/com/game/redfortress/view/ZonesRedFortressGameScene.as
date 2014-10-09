package com.game.redfortress.view
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.game.map.bean.*;
    import com.game.map.view.*;
    import com.game.redfortress.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import interfaces.role.*;

    public class ZonesRedFortressGameScene extends GameScene
    {

        public function ZonesRedFortressGameScene()
        {
            return;
        }// end function

        override protected function initPlayer() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo;
            _loc_1.showID = ZonesRedfortressModel.getVirturalModelId(_loc_1.job);
            _loc_1.weapon = null;
            _loc_1.weapon_other = null;
            _loc_1.wingInfo = null;
            if (_playerRole)
            {
                _playerRole.updatePosition();
            }
            else
            {
                _playerRole = Global.roleFactory.creatPlayer(_loc_1);
                _playerRole.isZonesMorph = true;
                _playerRole.addEvtListener(RoleEvent.ARRIVE, __arrive);
                addRole(_playerRole);
                _roleList.player = _playerRole;
            }
            _playerRole.resetCutePet();
            _playerRole.resetMagicBook();
            if (FrameworkGlobal.showHighLevelShadow)
            {
                super.showBottomLight(null);
            }
            return;
        }// end function

        override public function addRoleByInfo(param1:RoleInfo) : IRole
        {
            var _loc_3:* = 0;
            if (param1.roleType == RoleType.ROLE_TYPE_PLAYER)
            {
                _loc_3 = param1.job;
                param1.showID = ZonesRedfortressModel.getVirturalModelId(_loc_3);
                param1.weapon = null;
                param1.weapon_other = null;
                param1.wingInfo = null;
            }
            var _loc_2:* = _roleList.getRole(param1.personId);
            if (_loc_2)
            {
                return _loc_2;
            }
            _loc_2 = Global.roleFactory.creatRole(param1);
            _loc_2.isZonesMorph = true;
            addRole(_loc_2);
            _loc_2.updateAct();
            return _loc_2;
        }// end function

        override public function addNpcByCSInfo(param1:NpcInfo) : void
        {
            var _loc_2:* = new NpcShowInfo();
            _loc_2.npcInfo = param1;
            var _loc_3:* = Global.roleFactory.creatNpc(_loc_2);
            addNPC(_loc_3);
            return;
        }// end function

        override protected function addCutePet(param1:ICutePet, param2:Boolean = false) : void
        {
            if (param2)
            {
                _cutePetList.playerCutePet = param1;
            }
            _cutePetList.addCutePet(param1);
            return;
        }// end function

    }
}
