<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .message-popup {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 16px 24px;
        border-radius: 8px;
        background-color: white;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        display: flex;
        align-items: center;
        gap: 12px;
        z-index: 1000;
        animation: slideIn 0.3s ease-out;
    }

    .message-popup.error {
        border-left: 4px solid #EF4444;
    }

    .message-popup.success {
        border-left: 4px solid #22C55E;
    }

    .message-icon {
        width: 24px;
        height: 24px;
    }

    .message-content {
        color: #1F2937;
        font-size: 0.875rem;
    }

    .message-close {
        background: none;
        border: none;
        cursor: pointer;
        padding: 4px;
        margin-left: 8px;
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
</style>

<c:if test="${not empty message}">
    <div class="message-popup ${messageType}">
        <c:choose>
            <c:when test="${messageType eq 'error'}">
                <img src="${pageContext.request.contextPath}/assets/images/error_icon.svg" alt="Error" class="message-icon">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/assets/images/success_icon.svg" alt="Success" class="message-icon">
            </c:otherwise>
        </c:choose>
        <span class="message-content">${message}</span>
        <button class="message-close" onclick="this.parentElement.remove()">
            <img src="${pageContext.request.contextPath}/assets/images/close_icon.svg" alt="Close">
        </button>
    </div>
</c:if>

<script>
    function closeMessage() {
        const popup = document.getElementById('messagePopup');
        if (popup) {
            popup.style.animation = 'slideOut 0.3s ease-out forwards';
            setTimeout(() => {
                popup.remove();
            }, 300);
        }
    }

    // Auto-hide message after 5 seconds
    setTimeout(() => {
        closeMessage();
    }, 5000);
    
    // Additional debug
    window.addEventListener('load', function() {
        console.log('Page loaded, checking for message popup');
        const popup = document.getElementById('messagePopup');
        if (popup) {
            console.log('Message popup found after page load');
            console.log('Popup style:', window.getComputedStyle(popup));
        } else {
            console.log('No message popup found after page load');
        }
    });
</script> 