<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ page import="java.util.Base64" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>My Profile - MyDoctorApp</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Outfit', sans-serif;
                    }

                    body {
                        background-color: #f4f7fa;
                        min-height: 100vh;
                        color: #333;
                    }

                    .profile-container {
                        max-width: 800px;
                        margin: 2rem auto;
                        padding: 0 1rem;
                    }

                    .profile-card {
                        background: white;
                        border-radius: 0.75rem;
                        padding: 2rem;
                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                    }

                    .profile-header {
                        margin-bottom: 2rem;
                        position: relative;
                        width: 120px;
                        height: 120px;
                    }

                    .profile-image {
                        width: 100%;
                        height: 100%;
                        border-radius: 0.5rem;
                        object-fit: cover;
                    }

                    .profile-image-overlay {
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.4);
                        border-radius: 0.5rem;
                        display: none;
                        justify-content: center;
                        align-items: center;
                        cursor: pointer;
                    }

                    .profile-header.edit-mode:hover .profile-image-overlay {
                        display: flex;
                    }

                    .upload-icon {
                        width: 24px;
                        height: 24px;
                        opacity: 0.8;
                    }

                    .profile-name {
                        font-size: 1.75rem;
                        font-weight: 500;
                        color: #1a1a1a;
                        margin: 1rem 0;
                    }

                    .section-divider {
                        height: 1px;
                        background-color: #e5e7eb;
                        margin: 1.5rem 0;
                    }

                    .section-title {
                        color: #6b7280;
                        text-decoration: underline;
                        font-size: 0.875rem;
                        margin-bottom: 1rem;
                        text-transform: uppercase;
                    }

                    .info-grid {
                        display: grid;
                        grid-template-columns: 120px 1fr;
                        gap: 1rem;
                        margin: 1rem 0;
                    }

                    .info-label {
                        color: #374151;
                        font-weight: 500;
                        font-size: 0.875rem;
                    }

                    .info-value {
                        color: #374151;
                        font-size: 0.875rem;
                    }

                    .info-value.email {
                        color: #2563eb;
                        cursor: not-allowed;
                        opacity: 0.8;
                    }

                    .address-value {
                        color: #374151;
                    }

                    .edit-input {
                        width: 100%;
                        max-width: 300px;
                        padding: 0.5rem;
                        border: 1px solid #e5e7eb;
                        border-radius: 0.375rem;
                        font-size: 0.875rem;
                        color: #374151;
                        background-color: white;
                    }

                    .button {
                        display: inline-block;
                        padding: 0.5rem 2rem;
                        border: 1px solid #20B2AA;
                        border-radius: 9999px;
                        color: #20B2AA;
                        font-size: 0.875rem;
                        cursor: pointer;
                        background: none;
                        transition: all 0.2s;
                        margin-top: 1.5rem;
                    }

                    .button:hover {
                        background-color: #20B2AA;
                        color: white;
                    }

                    .hidden {
                        display: none;
                    }

                    /* Add styles for message box */
                    .message-box {
                        position: fixed;
                        top: 20px;
                        right: 20px;
                        padding: 1rem 2rem;
                        border-radius: 0.5rem;
                        color: white;
                        font-size: 0.875rem;
                        z-index: 1000;
                        animation: slideIn 0.3s ease-out;
                    }

                    .message-box.success {
                        background-color: #22c55e;
                    }

                    .message-box.error {
                        background-color: #ef4444;
                    }

                    .message-box.warning {
                        background-color: #f59e0b;
                    }

                    @keyframes slideIn {
                        from {
                            transform: translateX(100%);
                            opacity: 0;
                        }

                        to {
                            transform: translateX(0);
                            opacity: 1;
                        }
                    }

                    /* Auto-hide message after 3 seconds */
                    .message-box {
                        animation: slideIn 0.3s ease-out, fadeOut 0.3s ease-out 3s forwards;
                    }

                    @keyframes fadeOut {
                        from {
                            opacity: 1;
                        }

                        to {
                            opacity: 0;
                            visibility: hidden;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/components/navbar.jsp" />
                <jsp:include page="/WEB-INF/components/message.jsp" />

                <%
                    String base64Image = "";
                    if (session.getAttribute("user") != null) {
                        model.Patient patient = (model.Patient) session.getAttribute("user");
                        if (patient.getPfp() != null) {
                            base64Image = Base64.getEncoder().encodeToString(patient.getPfp());
                        }
                    }
                %>

                <div class="profile-container">
                    <div class="profile-card">
                        <form id="profileForm" action="${pageContext.request.contextPath}/update-profile" method="POST"
                            enctype="multipart/form-data">
                            <div class="profile-header">
                                <img class="profile-image"
                                    src="${empty sessionScope.user.pfp ? 
                                        pageContext.request.contextPath.concat('/assets/images/upload_area.png') : 
                                        pageContext.request.contextPath.concat('/patient-profile-image?id=').concat(sessionScope.user.patientId)}"
                                    alt="Profile Picture">
                                <div class="profile-image-overlay">
                                    <img src="${pageContext.request.contextPath}/assets/images/upload_icon.png"
                                        alt="Upload" class="upload-icon">
                                </div>
                                <input type="file" id="imageInput" name="image" class="hidden" accept="image/*">
                            </div>

                            <div class="profile-name">
                                <input type="text" id="nameInput" name="name" class="edit-input hidden"
                                    value="${sessionScope.user.name}">
                                <span id="nameDisplay">${sessionScope.user.name}</span>
                            </div>

                            <div class="section-divider"></div>

                            <div>
                                <p class="section-title">CONTACT INFORMATION</p>
                                <div class="info-grid">
                                    <span class="info-label">Email id:</span>
                                    <span class="info-value email">${sessionScope.user.email}</span>

                                    <span class="info-label">Phone:</span>
                                    <div>
                                        <input type="tel" id="phoneInput" name="phone" class="edit-input hidden"
                                            pattern="[0-9]{10}" title="Please enter a valid phone number"
                                            value="${sessionScope.user.phone}">
                                        <span id="phoneDisplay" class="info-value">${sessionScope.user.phone}</span>
                                    </div>

                                    <span class="info-label">Address:</span>
                                    <div>
                                        <input type="text" id="addressInput" name="addressLine1"
                                            class="edit-input hidden" value="${sessionScope.user.address}">
                                        <span id="addressDisplay"
                                            class="address-value">${sessionScope.user.address}</span>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <p class="section-title">BASIC INFORMATION</p>
                                <div class="info-grid">
                                    <span class="info-label">Gender:</span>
                                    <div>
                                        <select id="genderInput" name="gender" class="edit-input hidden">
                                            <option value="Male" ${sessionScope.user.gender eq 'Male' ? 'selected' : ''
                                                }>Male
                                            </option>
                                            <option value="Female" ${sessionScope.user.gender eq 'Female' ? 'selected'
                                                : '' }>
                                                Female</option>
                                        </select>
                                        <span id="genderDisplay" class="info-value">${sessionScope.user.gender}</span>
                                    </div>

                                    <span class="info-label">Birthday:</span>
                                    <div>
                                        <input type="date" id="dobInput" name="dob" class="edit-input hidden"
                                            value="<fmt:formatDate value='${sessionScope.user.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                                        <span id="dobDisplay" class="info-value">
                                            <fmt:formatDate value="${sessionScope.user.dateOfBirth}"
                                                pattern="yyyy-MM-dd" />
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <button type="button" id="editButton" class="button">Edit</button>
                            <button type="submit" id="saveButton" class="button hidden">Save information</button>
                        </form>
                    </div>
                </div>

                <script>
                    const editButton = document.getElementById('editButton');
                    const saveButton = document.getElementById('saveButton');
                    const imageInput = document.getElementById('imageInput');
                    const profileImage = document.querySelector('.profile-image');
                    const profileHeader = document.querySelector('.profile-header');
                    const form = document.getElementById('profileForm');

                    // Toggle edit mode
                    editButton.addEventListener('click', () => {
                        document.querySelectorAll('.edit-input').forEach(input => {
                            input.classList.remove('hidden');
                            const display = input.nextElementSibling;
                            if (display && display.id.endsWith('Display')) {
                                display.classList.add('hidden');
                            }
                        });
                        editButton.classList.add('hidden');
                        saveButton.classList.remove('hidden');
                        profileHeader.classList.add('edit-mode');
                    });

                    // Handle image upload preview
                    imageInput.addEventListener('change', (e) => {
                        if (e.target.files && e.target.files[0]) {
                            const reader = new FileReader();
                            reader.onload = (e) => {
                                profileImage.src = e.target.result;
                            };
                            reader.readAsDataURL(e.target.files[0]);
                        }
                    });

                    // Profile image click handler
                    profileHeader.addEventListener('click', () => {
                        if (profileHeader.classList.contains('edit-mode')) {
                            imageInput.click();
                        }
                    });

                    // Form submission handler
                    form.addEventListener('submit', function(e) {
                        e.preventDefault();
                        
                        const formData = new FormData(this);
                        
                        fetch(this.action, {
                            method: 'POST',
                            body: formData
                        })
                        .then(response => {
                            if (response.ok) {
                                // Add timestamp to force browser to reload the image
                                const timestamp = new Date().getTime();
                                const currentSrc = profileImage.src.split('?')[0];
                                profileImage.src = currentSrc + '?t=' + timestamp;
                                
                                // Remove edit mode
                                profileHeader.classList.remove('edit-mode');
                                
                                // Set success message in session
                                fetch('${pageContext.request.contextPath}/set-message', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: 'message=Profile updated successfully&type=success'
                                }).then(() => {
                                    // Reload the page after a short delay
                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 500);
                                });
                            } else {
                                throw new Error('Profile update failed');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            // Set error message in session
                            fetch('${pageContext.request.contextPath}/set-message', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'message=Failed to update profile. Please try again.&type=error'
                            }).then(() => {
                                window.location.reload();
                            });
                        });
                    });
                </script>
            </body>

            </html>