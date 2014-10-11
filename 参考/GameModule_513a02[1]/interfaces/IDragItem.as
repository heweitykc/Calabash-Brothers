package interfaces
{
    import flash.geom.*;

    public interface IDragItem
    {

        public function IDragItem();

        function dragEnter() : void;

        function dragAccept(param1:IDragItem, param2:Object = null) : Boolean;

        function dragOut() : void;

        function dragSucc(param1:Boolean, param2:Point = null) : void;

        function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void;

        function getKey() : String;

        function acceptKey() : Array;

    }
}
