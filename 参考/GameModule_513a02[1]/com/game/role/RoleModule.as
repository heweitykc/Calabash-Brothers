package com.game.role
{
    import com.*;
    import com.game.role.view.*;
    import com.model.*;
    import com.model.vo.*;
    import com.netease.protobuf.*;
    import interfaces.role.*;

    public class RoleModule extends Object implements IRoleFactory
    {

        public function RoleModule()
        {
            Global.roleFactory = this;
            return;
        }// end function

        public function creatRoleView(param1:RoleInfo = null) : IRoleView
        {
            var _loc_2:* = new RoleView();
            if (param1 != null)
            {
                _loc_2.info = param1;
            }
            return _loc_2;
        }// end function

        public function creatRoleNotByInfo(param1:String, param2:String) : ISimpleRole
        {
            return null;
        }// end function

        public function creatPlayer(param1:PlayerInfo, param2:Boolean = true) : IRole
        {
            var _loc_3:* = null;
            if (RoleList.getInstance().player)
            {
                _loc_3 = RoleList.getInstance().player;
            }
            else
            {
                _loc_3 = new Player();
                _loc_3.info = param1;
            }
            return _loc_3;
        }// end function

        public function creatRole(param1:RoleInfo, param2:Boolean = true) : IRole
        {
            var _loc_3:* = new Role();
            _loc_3.info = param1;
            return _loc_3;
        }// end function

        public function createClientRole(param1:RoleInfo, param2:Boolean = true) : IRole
        {
            var _loc_3:* = new ClientMonster();
            _loc_3.info = param1;
            _loc_3.direct = param1.direct;
            return _loc_3;
        }// end function

        public function creatNpc(param1:RoleInfo, param2:Boolean = true) : INpc
        {
            var _loc_3:* = NpcList.getInstance().getNpcByCfgId(param1.cfgId) as NPC;
            if (_loc_3)
            {
                return _loc_3;
            }
            var _loc_4:* = new NPC();
            _loc_4.info = param1;
            return _loc_4;
        }// end function

        public function creatSimpleRole(param1:RoleInfo) : ISimpleRole
        {
            return null;
        }// end function

        public function creatSimpleRoleByCfgID(param1:UInt64, param2:String, param3:uint, param4:uint) : ISimpleRole
        {
            return null;
        }// end function

        public function createCutePet(param1:CutePetInfo) : ICutePet
        {
            var _loc_2:* = null;
            switch(param1.petType)
            {
                case 5:
                {
                    _loc_2 = new CutePet();
                    break;
                }
                case 6:
                {
                    _loc_2 = new FlyCutePet();
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.info = param1;
            return _loc_2;
        }// end function

        public function createMagicBookRole(param1:MagicBookInfo) : IMagicBookRole
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_3 = new MagicBookRole();
            _loc_3.info = param1;
            return _loc_3;
        }// end function

        public function createPlayerCutePet(param1:CutePetInfo) : ICutePet
        {
            var _loc_2:* = null;
            switch(param1.petType)
            {
                case 5:
                {
                    _loc_2 = new PlayerCutePet();
                    break;
                }
                case 6:
                {
                    _loc_2 = new FlyCutePet();
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.info = param1;
            return _loc_2;
        }// end function

    }
}
