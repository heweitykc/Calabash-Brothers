package interfaces.role
{
    import com.model.vo.*;
    import com.netease.protobuf.*;

    public interface IRoleFactory
    {

        public function IRoleFactory();

        function creatPlayer(param1:PlayerInfo, param2:Boolean = true) : IRole;

        function creatRole(param1:RoleInfo, param2:Boolean = true) : IRole;

        function createClientRole(param1:RoleInfo, param2:Boolean = true) : IRole;

        function creatNpc(param1:RoleInfo, param2:Boolean = true) : INpc;

        function creatSimpleRole(param1:RoleInfo) : ISimpleRole;

        function creatRoleView(param1:RoleInfo = null) : IRoleView;

        function creatRoleNotByInfo(param1:String, param2:String) : ISimpleRole;

        function creatSimpleRoleByCfgID(param1:UInt64, param2:String, param3:uint, param4:uint) : ISimpleRole;

        function createCutePet(param1:CutePetInfo) : ICutePet;

        function createPlayerCutePet(param1:CutePetInfo) : ICutePet;

        function createMagicBookRole(param1:MagicBookInfo) : IMagicBookRole;

    }
}
