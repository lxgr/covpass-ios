//
//  StartOnboardingViewModel.swift
//
//
//  Copyright © 2021 IBM. All rights reserved.
//

import UIKit
import VaccinationCommon

enum Result {
    case full
    case partial
    case error
}

open class ValidationResultViewModel: BaseViewModel {

    public init(certificate: ValidationCertificate?) {
        self.certificate = certificate
    }

    private var result: Result {
        guard let cert = certificate else {
            return .error
        }
        return cert.partialVaccination ? .partial : .full
    }
    private var certificate: ValidationCertificate?

    open var icon: UIImage? {
        switch result {
        case .full:
            return UIImage(named: "result_success", in: UIConstants.bundle, compatibleWith: nil)
        case .partial, .error:
            return UIImage(named: "result_error", in: UIConstants.bundle, compatibleWith: nil)
        }
    }

    open var resultTitle: String {
        switch result {
        case .full:
            return "Impfschutz gültig"
        case .partial:
            return "Impfschutz nicht vollständig"
        case .error:
            return "Prüfung nicht erfolgreich"
        }
    }

    open var resultBody: String {
        switch result {
        case .full:
            return "Gleichen Sie jetzt folgende Daten mit dem Personalausweis oder Reisepass ab."
        case .partial:
            return "Das geprüfte Zertifikat weist keine vollständige Impfung nach."
        case .error:
            return "Das kann zwei Gründe haben:"
        }
    }

    open var nameTitle: String? {
        switch result {
        case .full, .partial:
            return certificate?.name
        case .error:
            return "Impfnachweis nicht gefunden"
        }
    }

    open var nameBody: String? {
        switch result {
        case .full, .partial:
            if let date = certificate?.birthDate {
                return "Geboren am \(DateUtils.displayDateFormatter.string(from: date))"
            }
            return nil
        case .error:
            return "Es sind keine Daten auf dem Prüfzertifikat gespeichert. Sollten Sie sich im Offline-Modus befinden, aktualisieren Sie die App."
        }
    }

    open var idTitle: String? {
        switch result {
        case .full, .partial:
            return "Ausweis-Nummer"
        case .error:
            return "Impfnachweis abgelaufen"
        }
    }

    open var idBody: String? {
        switch result {
        case .full, .partial:
            return nil
        case .error:
            return "Das Prüfzertifikat ist nicht mehr gültig. Der aktuelle Status kann in der Impf-Nachweis-App eingesehen werden."
        }
    }

    var closeButtonImage: UIImage? {
        UIImage(named: UIConstants.IconName.IconClose, in: UIConstants.bundle, compatibleWith: nil)
    }

    // MARK - PopupRouter

    let height: CGFloat = 650
    let topCornerRadius: CGFloat = 20
    let presentDuration: Double = 0.5
    let dismissDuration: Double = 0.5
    let shouldDismissInteractivelty: Bool = true

    //
    public var image: UIImage?

    public var title: String = ""

    public var info: String = ""

    public var imageAspectRatio: CGFloat = 0.0

    public var imageWidth: CGFloat = 0.0

    public var imageHeight: CGFloat = 0.0

    public var imageContentMode: UIView.ContentMode = .scaleAspectFit

    public var headlineFont: UIFont = UIFont.boldSystemFont(ofSize: 12)

    public var headlineColor: UIColor = UIColor.black

    public var paragraphBodyFont: UIFont = UIFont.boldSystemFont(ofSize: 12)

    public var backgroundColor: UIColor = UIColor.black
}

