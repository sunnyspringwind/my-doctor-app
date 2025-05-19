import appointment_img from './appointment_img.png'
import header_img from './header_img.png'
import group_profiles from './group_profiles.png'
import profile_pic from './profile_pic.png'
import contact_image from './contact_image.png'
import about_image from './about_image.png'
import logo from './mainlogo.svg'
import dropdown_icon from './dropdown_icon.svg'
import menu_icon from './menu_icon.svg'
import cross_icon from './cross_icon.png'
import chats_icon from './chats_icon.svg'
import verified_icon from './verified_icon.svg'
import arrow_icon from './arrow_icon.svg'
import info_icon from './info_icon.svg'
import upload_icon from './upload_icon.png'
import stripe_logo from './stripe_logo.png'
import razorpay_logo from './razorpay_logo.png'
import doc1 from './doc1.png'
import doc2 from './doc2.png'
import doc3 from './doc3.png'
import doc4 from './doc4.png'
import doc5 from './doc5.png'
import doc6 from './doc6.png'
import doc7 from './doc7.png'
import doc8 from './doc8.png'
import doc9 from './doc9.png'
import doc10 from './doc10.png'
import doc11 from './doc11.png'
import doc12 from './doc12.png'
import doc13 from './doc13.png'
import doc14 from './doc14.png'
import doc15 from './doc15.png'
import Dermatologist from './Dermatologist.svg'
import Gastroenterologist from './Gastroenterologist.svg'
import General_physician from './General_physician.svg'
import Gynecologist from './Gynecologist.svg'
import Neurologist from './Neurologist.svg'
import Pediatricians from './Pediatricians.svg'
import add_icon from './add_icon.svg'
import admin_logo from './admin_logo.svg'
import appointment_icon from './appointment_icon.svg'
import cancel_icon from './cancel_icon.svg'
import doctor_icon from './doctor_icon.svg'
import home_icon from './home_icon.svg'
import people_icon from './people_icon.svg'
import upload_area from './upload_area.svg'
import list_icon from './list_icon.svg'
import tick_icon from './tick_icon.svg'
import appointments_icon from './appointments_icon.svg'
import earning_icon from './earning_icon.svg'
import patients_icon from './patients_icon.svg'


export const assets = {
    appointment_img,
    header_img,
    group_profiles,
    logo,
    chats_icon,
    verified_icon,
    info_icon,
    profile_pic,
    arrow_icon,
    contact_image,
    about_image,
    menu_icon,
    cross_icon,
    dropdown_icon,
    upload_icon,
    stripe_logo,
    razorpay_logo,
    add_icon,
    admin_logo,
    appointment_icon,
    cancel_icon,
    doctor_icon,
    upload_area,
    home_icon,
    patients_icon,
    people_icon,
    list_icon,
    tick_icon,
    appointments_icon,
    earning_icon
}

export const specialityData = [
    {
        speciality: 'General physician',
        image: General_physician
    },
    {
        speciality: 'Gynecologist',
        image: Gynecologist
    },
    {
        speciality: 'Dermatologist',
        image: Dermatologist
    },
    {
        speciality: 'Pediatricians',
        image: Pediatricians
    },
    {
        speciality: 'Neurologist',
        image: Neurologist
    },
    {
        speciality: 'Gastroenterologist',
        image: Gastroenterologist
    },
]

export const doctors = [
    {
        _id: 'doc1',
        name: 'Dr. Ganesh Lama',
        image: doc1,
        speciality: 'General physician',
        degree: 'MBBS',
        experience: '15 Years',
        about: 'Dr. Ganesh Lama is a highly skilled consultant physician specializing in internal medicine. Dr. Lama is known for his dedication to patient care and his involvement in community health initiatives. He currently practices at Bir Hospital, Clinic One, and Stupa Community Hospital.',
        fees: 1000,
        address: {
            line1: '2nd Floor, Norkhang Complex, Jawalakhel',
            line2: 'Lalitpur, Kathmandu, Nepal'
        }
    },
    {
        _id: 'doc2',
        name: 'Dr. Bandana Khanal',
        image: doc2,
        speciality: 'Gynecologist',
        degree: 'MBBS',
        experience: '10 Years',
        about: 'Dr. Bandana Khanal specializes in obstetrics and gynecology, providing care for womans reproductive health, fertility issues, and high-risk pregnancies. She is also involved in medical research and community health initiatives.',
        fees: 1000,
        address: {
            line1: 'Chitwan Medical College, Bharatpur',
            line2: 'Chitwan, Nepal'
        },        
    },
    {
        _id: 'doc3',
        name: 'Dr. Anil Kumar Bhatta',
        image: doc3,
        speciality: 'Dermatologist',
        degree: 'MBBS',
        experience: '14 Years',
        about: 'Dr. Anil Kumar Bhatta is a highly skilled dermatologist, venereologist, and aesthetician specializing in advanced skin treatments, laser procedures, and cosmetic dermatology. Dr. Bhatta is known for his expertise in Botox, dermal fillers, face lifting, and comprehensive skin care solutions.',
        fees: 1200,
        address: {
            line1: 'Derm Dynamics Skin Hair & Laser Clinic, Kumaripati',
            line2: 'Lalitpur, Kathmandu, Nepal'
        }
    },
    {
        _id: 'doc4',
        name: 'Dr. Arnav Shrestha',
        image: doc4,
        speciality: 'Pediatricians',
        degree: 'MBBS',
        experience: '10 Years',
        about: 'Dr. Arnav Shrestha is a compassionate and experienced pediatrician with over a decade of expertise in child health and neonatology. He is dedicated to providing comprehensive care for infants, children, and adolescents, addressing a wide range of health concerns with precision and empathy.',
        fees: 1200,
        address: {
            line1: 'Nepal Mediciti Hospital, Nakkhu',
            line2: 'Lalitpur, Nepal'
        }
    },
    {
        _id: 'doc5',
        name: 'Dr. Isha Dhungana',
        image: doc5,
        speciality: 'Neurologist',
        degree: 'MBBS',
        experience: '20 Years',
        about: 'Dr. Isha Dhungana Shrestha is a highly accomplished neurologist with an MBBS, MD, and PhD from Japan. She specializes in diagnosing and treating complex neurological disorders, including migraines, epilepsy, and strokes. Her dedication to patient care and her expertise in the field have made her a trusted name in neurology.',
        fees: 1500,
        address: {
            line1: 'B&B Hospital, Gwarko',
            line2: 'Lalitpur, Nepal'
        }
        
    },
    {
        _id: 'doc6',
        name: 'Dr. Shekhar Poudel',
        image: doc6,
        speciality: 'Gastroenterologist',
        degree: 'MBBS',
        experience: '9 Years',
        about: 'Dr Shekhar Poudel is a highly skilled gastroenterologist and hepatologist specializing in advanced endoscopic procedures and liver transplant care. He is known for his expertise in treating gastrointestinal disorders and his compassionate approach to patient care.',
        fees: 1500,
        address: {
            line1: 'Norvic International Hospital, Thapathali',
            line2: 'Kathmandu, Nepal'
        }        
    },
    {
        _id: 'doc7',
        name: 'Dr. Kovid Nepal',
        image: doc7,
        speciality: 'General physician',
        degree: 'MBBS',
        experience: '12 Years',
        about: 'Dr. Kovid Nepal is a dedicated general physician specializing in internal medicine and laparoscopic surgery. He is known for his expertise in treating a wide range of medical conditions, including gastrointestinal issues and chronic illnesses. His compassionate approach and commitment to providing quality healthcare have earned him a strong reputation.',
        fees: 1000,
        address: {
            line1: 'Charak Memorial Hospital, Nagdhunga',
            line2: 'Pokhara-8, Kaski, Nepal'
        }
        
    },
    {
        _id: 'doc8',
        name: 'Dr. Parag karki',
        image: doc8,
        speciality: 'Gynecologist',
        degree: 'MBBS',
        experience: '12 Years',
        about: 'Dr. Parag Karki is a highly skilled gynecologist specializing in womans reproductive health, prenatal care, and high-risk pregnancies. He is known for his compassionate approach and dedication to providing comprehensive care.',
        fees: 1200,
        address: {
            line1: 'Norvic International Hospital, Thapathali',
            line2: 'Kathmandu, Nepal'
        }        
    },
    {
        _id: 'doc9',
        name: 'Dr. Subekcha Karki',
        image: doc9,
        speciality: 'Dermatologist',
        degree: 'MBBS',
        experience: '8 Years',
        about: 'Dr. Subekcha Karki is a highly skilled dermatologist specializing in pediatric dermatology, cosmetology, and laser therapy. She is known for her expertise in treating various skin conditions and her compassionate approach to patient care. Dr. Karki is actively involved in research and has multiple publications in national and international journals.',
        fees: 1200,
        address: {
            line1: 'DI Skin Hospital, Golfutar',
            line2: 'Budhanilkantha, Kathmandu, Nepal'
        }        
    },
    {
        _id: 'doc10',
        name: 'Dr. Poonam Sharma',
        image: doc10,
        speciality: 'Pediatricians',
        degree: 'MBBS',
        experience: '15 Years',
        about: 'Dr. Poonam Sharma is a dedicated pediatrician specializing in pediatric cardiology, including imaging and catheter intervention for congenital heart diseases. She is known for her compassionate care and expertise in managing complex cardiac conditions in children. Dr. Sharma is actively involved in research and has contributed significantly to improving outcomes for young patients.',
        fees: 1500,
        address: {
            line1: 'Nepal Mediciti Hospital, Nakkhu',
            line2: 'Lalitpur, Nepal'
        }        
    },
    {
        _id: 'doc11',
        name: 'Dr. Babu Ram Pokharel',
        image: doc11,
        speciality: 'Neurologist',
        degree: 'MBBS',
        experience: '15 Years',
        about: 'Dr. Babu Ram Pokharel is a highly accomplished neurologist specializing in the diagnosis and treatment of neurological disorders, including strokes, epilepsy, and movement disorders. He is the Principal Consultant and Head of the Department of Neurology at Nepal Mediciti Hospital. Known for his dedication to patient care and medical research, Dr. Pokharel has contributed significantly to advancing neurology in Nepal.',
        fees: 1500,
        address: {
            line1: 'Nepal Mediciti Hospital, Bhaisepati',
            line2: 'Lalitpur, Nepal'
        }        
    },
    {
        _id: 'doc12',
        name: 'Dr. Neeraj Joshi',
        image: doc12,
        speciality: 'Gastroenterologist',
        degree: 'MBBS',
        experience: '25 Years',
        about: 'Dr. Neeraj Joshi is a highly accomplished gastroenterologist specializing in advanced endoscopic procedures, chronic liver diseases, and inflammatory bowel diseases. He has trained extensively in Nepal, India, and the UK, earning prestigious qualifications such as MRCP and CCT in Gastroenterology. Dr. Joshi is known for his dedication to ethical and evidence-based medicine, providing holistic care tailored to each patient.',
        fees: 1500,
        address: {
            line1: 'Nepal Mediciti Hospital, Bhaisepati',
            line2: 'Lalitpur, Nepal'
        }        
    },
    {
        _id: 'doc13',
        name: 'Dr. Priyanka Tripathi',
        image: doc13,
        speciality: 'General physician',
        degree: 'MBBS',
        experience: '6 Years',
        about: 'Dr. Priyanka Tripathi is a highly skilled physician based in Nepal, with extensive experience in full body checkup. She has worked with renowned institutions like Clinic One, Frontline Hospital, and WHO, contributing to womans health and education. Dr. Tripathi is known for her dedication to patient care.',
        fees: 1050,
        address: {
            line1: 'Bir Hospital, Mahaboudha',
            line2: 'Kathmandu, Nepal'
        }
    },
    {
        _id: 'doc14',
        name: 'Dr. Basant Sharma',
        image: doc14,
        speciality: 'Gynecologist',
        degree: 'MBBS',
        experience: '15 Years',
        about: 'Dr. Basant Sharma is a highly skilled gynecologist specializing in womans reproductive health, prenatal care, and gynecologic surgeries. He is known for his compassionate approach and dedication to providing personalized care to his patients. Dr. Sharma is actively involved in medical research and community health initiatives, ensuring the highest standards of healthcare.',
        fees: 1200,
        address: {
            line1: 'Bir Hospital, Mahaboudha',
            line2: 'Kathmandu, Nepal'
        }        
    },
    {
        _id: 'doc15',
        name: 'Dr. Siree Thapa',
        image: doc15,
        speciality: 'Dermatologist',
        degree: 'MBBS',
        experience: '5 Years',
        about: 'Dr. Siree Thapa is a dedicated dermatologist specializing in laser surgery and aesthetic procedures. She is known for her expertise in treating various skin conditions and her compassionate approach to patient care. Dr. Thapa is currently associated with DI Skin Hospital and Referral Center, where she provides comprehensive dermatological services.',
        fees: 1200,
        address: {
            line1: 'DI Skin Hospital, Golfutar',
            line2: 'Budhanilkantha, Kathmandu, Nepal'
        }        
    },
]