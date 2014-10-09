package interfaces
{
    import com.model.vo.*;

    public interface IEquiptipControl
    {

        public function IEquiptipControl();

        function getEquip(param1:EquipmentInfo) : EquipmentInfo;

        function isOtherEquip(param1:EquipmentInfo) : Boolean;

        function getSuitCount(param1:int, param2:int, param3:int) : int;

        function getOtherSuitCount(param1:int, param2:int, param3:int) : int;

        function getToplistSuitCount(param1:int, param2:int, param3:int) : int;

    }
}
