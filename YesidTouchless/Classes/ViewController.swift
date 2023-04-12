import UIKit

class ViewController: UIViewController {
    
    public var orientation:UInt32 = 0
    
    public var progress:UInt32 = 0
    
    public var showDialog:Bool = true
    
    @Published var viewModel:TouchlessViewModel = TouchlessViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //configOnyx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configOnyx()
    }
    
    func configOnyx(){
        let onyxConfig: OnyxConfiguration = OnyxConfiguration();
        onyxConfig.viewController = self
        onyxConfig.licenseKey = "2645-6424-6150-1-2"
        onyxConfig.returnRawFingerprintImage = false
        onyxConfig.returnProcessedFingerprintImage = true
        onyxConfig.returnGrayRawFingerprintImage = false
        onyxConfig.returnGrayRawWsq = false
        onyxConfig.returnWsq = false
        onyxConfig.reticleOrientation = ReticleOrientation(rawValue: self.orientation)
        onyxConfig.showSpinner = true
        onyxConfig.useLiveness = false
        onyxConfig.onyxCallback = onyxCallback
        onyxConfig.successCallback = onyxSuccessCallback
        onyxConfig.errorCallback = onyxErrorCallback
        
        let onyx: Onyx = Onyx()
        onyx.doSetup(onyxConfig)
    }
    
    func onyxCallback(configuredOnyx: Onyx?) -> Void {
        DispatchQueue.main.async {
            configuredOnyx?.capture(self)
            self.viewModel.viewController = configuredOnyx?.viewController
        }
    }
    
    func onyxSuccessCallback(onyxResult: OnyxResult?) -> Void {
        self.returningResults(onyxResult: onyxResult)
    }
    
    func onyxErrorCallback(onyxError: OnyxError?) -> Void {
        print("Touchless error")
    }
    
    func returningResults(onyxResult:OnyxResult?){
        if(self.orientation == 0){
            // left hand
            //print("here is left results")
            self.viewModel.leftFingerResult = onyxResult
            self.viewModel.isLeftFingerScan = true
        }else if(orientation==1){
            // right hand
           // print("here is right results")
            self.viewModel.rightFingerResult = onyxResult
            self.viewModel.isRightFingerScan = true
        }else if(progress==3) {
           // print("here is lefthumb results")
            self.viewModel.leftThumbResult = onyxResult
            self.viewModel.isLeftThumbScan = true
        }else if(progress==1){
           // print("here is rightthumb results")
            self.viewModel.rightThumbResult = onyxResult
            self.viewModel.isRightThumbScan = true
        }else{
            print("nothing")
        }
    }
}
